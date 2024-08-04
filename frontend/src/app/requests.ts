export const api_origin = "http://localhost:5000";

export const getNewsData = async () => {
  const response = await fetch(`${api_origin}/api/v1/news`);
  const data = await response.json();
  return data;
};
