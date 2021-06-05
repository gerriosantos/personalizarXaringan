

## Exemplo para solucao

---
  title: "R Notebook"
output:
  html_document:
  df_print: paged
---

  {r pressure,fig.width=6,echo=FALSE,message=FALSE,results="asis"}

attach(airquality)
for(i in unique(Month)) {
  cat("  \n###",  month.name[i], "Air Quaility  \n")
  #print(plot(airquality[airquality$Month == i,]))
  plot(airquality[airquality$Month == i,])
  cat("  \n")
}
