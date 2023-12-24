function handler(event) {
  var request = event.request;
  var headers = request.headers;

  // ${authString} の部分は Terraform から埋め込まれる
  var authString = "Basic ${authString}";

  // Authorization ヘッダを検証
  if (
    typeof headers.authorization === "undefined" ||
    headers.authorization.value !== authString
  ) {
    return {
      statusCode: 401,
      statusDescription: "Unauthorized",
      headers: {
        "www-authenticate": { value: "Basic" },
      },
    };
  }

  return request;
}
