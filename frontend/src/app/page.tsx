import Link from "next/link";
import { formatDateTime } from "@/app/utilities";
import { getNewsData } from "@/app/requests";

export default async function Home() {
  const news = await getNewsData();

  return (
    news && (
      <section className="max-w-4xl">
        {news.map((article: any) => (
          <article key={article.id} className="mb-8">
            <h2>
              <Link
                href={article.url}
                target="_blank"
                rel="noopener noreferrer"
              >
                {article.title}
              </Link>
            </h2>
            {article.published_at && (
              <time dateTime={article.published_at} className="mb-4 block">
                {formatDateTime(article.published_at)}
              </time>
            )}
            <p>{article.summary}</p>
          </article>
        ))}
      </section>
    )
  );
}
