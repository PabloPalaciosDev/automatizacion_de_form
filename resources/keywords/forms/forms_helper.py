import base64
import os
 
MESES_MAP = {
    "January": "0",  "Jan": "0",
    "February": "1", "Feb": "1",
    "March": "2",    "Mar": "2",
    "April": "3",    "Apr": "3",
    "May": "4",
    "June": "5",     "Jun": "5",
    "July": "6",     "Jul": "6",
    "August": "7",   "Aug": "7",
    "September": "8","Sep": "8",
    "October": "9",  "Oct": "9",
    "November": "10","Nov": "10",
    "December": "11","Dec": "11",
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
    with open(ruta, "rb") as f:
        contenido = f.read()
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
    d = str(dia)
    return (
        "var days=document.querySelectorAll("
        "'.react-datepicker__day:not(.react-datepicker__day--outside-month)');"
        f"for(var i=0;i<days.length;i++){{if(days[i].textContent.trim()==='{d}'){{days[i].click();break;}}}}"
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
 
def js_click_estado():
    return (
        "var el = document.querySelector('#state [class*=\"control\"]');"
        "if(!el) el = document.getElementById('state');"
        "el.scrollIntoView({block:'center'});"
        "el.click();"
    )

def js_click_ciudad():
    return (
        "var el = document.querySelector('#city [class*=\"control\"]');"
        "if(!el) el = document.getElementById('city');"
        "el.scrollIntoView({block:'center'});"
        "el.click();"
    )
 
def js_click_opcion_dropdown(texto):
    """
    Busca en los divs con rol 'option' del React Select (demoqa).
    Más preciso que buscar por class*=option que devuelve demasiados elementos.
    """

def js_click_opcion_dropdown(texto):
    t = str(texto)
    return (
        "var found = false;"
        "var divs = document.querySelectorAll('div[id*=\"option\"]');"
        f"for(var i=0;i<divs.length;i++){{"
        f"  if(divs[i].textContent.trim()==='{t}'){{"
        f"    divs[i].click(); found=true; break;"
        f"  }}"
        f"}}"
        "if(!found){"
        "  var spans = document.querySelectorAll('div[class*=\"option\"]');"
        f"  for(var j=0;j<spans.length;j++){{"
        f"    if(spans[j].textContent.trim()==='{t}'){{"
        f"      spans[j].click(); break;"
        f"    }}"
        f"  }}"
        "}"
    )
 