#' Internal method for refreshing the access token.
#' @description Uses a hidden function from the httr package to refresh the access token.
#' @return A character string containing a valid access token.

._pbiRefresh <- function(
  urls = .powerbi.urls,
  app = .powerbi.app,
  cred = .powerbi.token$credentials
  )
{

  ## Run httr refresh function.
  token = try(
    httr:::refresh_oauth2.0(
      urls, app, cred,
      user_params = list(resource = "https://analysis.windows.net/powerbi/api")
      ))

  if(is(token, "try-error")) {
    warning("Could not refresh the access token. *shrugs*.")
    return(NULL)
  }

  .expires <<- as.numeric(token$expires_on)

  ## Reassign the hidden token value.
  return(token$access_token)

}