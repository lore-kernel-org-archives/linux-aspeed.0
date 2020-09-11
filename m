From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 11 Sep 2020 08:10:53 +0200
Subject: [PATCH v2 12/15] ARM: dts: aspeed: align GPIO hog names with
 dtschema
In-Reply-To: <CACPK8XfmDySpkCw8nkmns-euGQE6JTqZLVO6JhvFJiRqNosRuQ@mail.gmail.com>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-13-krzk@kernel.org>
 <CACPK8XfmDySpkCw8nkmns-euGQE6JTqZLVO6JhvFJiRqNosRuQ@mail.gmail.com>
Message-ID: <CAJKOXPca3R=LYVws9rYj-iuOx7Z1GMkM2ow2pCQ3CGnv0vSS7Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2020 at 02:58, Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 10 Sep 2020 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > dtschema for pca95xx expects GPIO hogs to end with 'hog' prefix.
>
> This is a bit ugly. Do we have to go down this path?

No, but please comment on schema (1/15 in this series).

Best regards,
Krzysztof
