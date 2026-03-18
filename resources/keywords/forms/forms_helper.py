import base64
import os

MESES_MAP = {
    "January": "0",
    "Jan": "0",
    "February": "1",
    "Feb": "1",
    "March": "2",
    "Mar": "2",
    "April": "3",
    "Apr": "3",
    "May": "4",
    "June": "5",
    "Jun": "5",
    "July": "6",
    "Jul": "6",
    "August": "7",
    "Aug": "7",
    "September": "8",
    "Sep": "8",
    "October": "9",
    "Oct": "9",
    "November": "10",
    "Nov": "10",
    "December": "11",
    "Dec": "11",
}


def obtener_indice_mes(mes):
    mes_str = str(mes).strip()
    if mes_str in MESES_MAP:
        return MESES_MAP[mes_str]
    try:
        num = int(mes_str)
        if 1 <= num <= 12:
            return str(num - 1)
    except ValueError:
        pass
    raise ValueError(f"Mes no reconocido: '{mes}'")


def leer_archivo_base64(ruta_archivo):
    ruta = ruta_archivo.strip()
    if not os.path.isfile(ruta):
        raise FileNotFoundError(f"Archivo no encontrado: '{ruta}'")
    with open(ruta, "rb") as file:
        contenido = file.read()
    return base64.b64encode(contenido).decode("utf-8")


def js_abrir_datepicker():
    return "document.getElementById('dateOfBirthInput').click();"


def js_seleccionar_mes(mes_idx):
    idx = str(mes_idx)
    return (
        "var sel=document.querySelector('.react-datepicker__month-select');"
        f"sel.value='{idx}';"
        "sel.dispatchEvent(new Event('change',{bubbles:true}));"
    )


def js_seleccionar_anio(anio):
    yr = str(anio)
    return (
        "var sel=document.querySelector('.react-datepicker__year-select');"
        f"sel.value='{yr}';"
        "sel.dispatchEvent(new Event('change',{bubbles:true}));"
    )


def js_seleccionar_dia(dia):
    day = str(dia)
    return (
        "var days=document.querySelectorAll("
        "'.react-datepicker__day:not(.react-datepicker__day--outside-month)');"
        f"for(var i=0;i<days.length;i++){{if(days[i].textContent.trim()==='{day}'){{days[i].click();break;}}}}"
    )


def js_click_genero(genero):
    return f"document.querySelector(\"input[value='{genero}']\").click();"


def js_click_hobby(hobby_id):
    return (
        f"var el=document.getElementById('{hobby_id}');"
        "el.scrollIntoView({block:'center'});"
        "window.scrollBy(0,-100);"
        "setTimeout(function(){el.click();},500);"
    )


def js_scroll_bottom():
    return "window.scrollTo(0, document.body.scrollHeight);"


def js_click_submit():
    return "document.getElementById('submit').click();"


def js_scroll_to_upload():
    return "document.getElementById('uploadPicture').scrollIntoView({block:'center'});"


def js_simular_upload():
    return (
        "var input = document.getElementById('uploadPicture');"
        "var dt = new DataTransfer();"
        "var file = new File([''], 'foto.jpg', {type: 'image/jpeg'});"
        "dt.items.add(file);"
        "input.files = dt.files;"
        "input.dispatchEvent(new Event('change', {bubbles: true}));"
    )


def js_click_primera_opcion_subject():
    return (
        "var opts = document.querySelectorAll('[class*=\"subjects-auto-complete__option\"]');"
        "if(opts.length > 0){ opts[0].click(); }"
    )


def _escape_js_string(texto):
    return str(texto).replace("\\", "\\\\").replace("'", "\\'")


def _js_open_react_select(contenedor_id, nombre):
    cid = _escape_js_string(contenedor_id)
    label = _escape_js_string(nombre)
    return (
        f"var wrap=document.getElementById('{cid}');"
        f"if(!wrap){{throw new Error('No existe el contenedor {label}');}}"
        "var control=wrap.querySelector('div[class*=\"control\"]');"
        f"if(!control){{throw new Error('No se encontro el control de {label}');}}"
        "control.scrollIntoView({block:'center'});"
        "control.dispatchEvent(new MouseEvent('mousedown',{bubbles:true,cancelable:true,view:window}));"
        "control.click();"
    )


def js_click_estado():
    return _js_open_react_select("state", "State")


def js_click_ciudad():
    return _js_open_react_select("city", "City")


def js_click_opcion_dropdown(contenedor_id, texto):
    cid = _escape_js_string(contenedor_id)
    target = _escape_js_string(texto)
    return (
        f"var wrap=document.getElementById('{cid}');"
        f"if(!wrap){{throw new Error('No existe contenedor de dropdown: {cid}');}}"
        "var input=wrap.querySelector('input[id$=\"-input\"]');"
        f"if(!input){{throw new Error('No se encontro input React Select en {cid}');}}"
        "var optionPrefix=input.id.replace('-input','-option-');"
        "var options=document.querySelectorAll('div[id^=\"'+optionPrefix+'\"]');"
        "if(options.length===0){ options=document.querySelectorAll('div[role=\"option\"]'); }"
        "var clicked=false;"
        "for(var i=0;i<options.length;i++){"
        f"  if(options[i].textContent.trim()==='{target}'){{"
        "    options[i].dispatchEvent(new MouseEvent('mousedown',{bubbles:true,cancelable:true,view:window}));"
        "    options[i].click();"
        "    clicked=true;"
        "    break;"
        "  }"
        "}"
        "if(!clicked){"
        f"  throw new Error('No se encontro opcion visible: {target}');"
        "}"
    )
