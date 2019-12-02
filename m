From: Joel Stanley <joel@jms.id.au>
Date: Mon, 2 Dec 2019 21:57:59 +0000
Subject: [PATCH v3 3/3] mmc: sdhci-of-aspeed: add inversion signal presence
In-Reply-To: <CAPDyKFrshWd1P9dZGTSuU=5P0L6LSPz=v2nn+0SWi3ZZazKrRw@mail.gmail.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-4-i.mikhaylov@yadro.com>
 <CAPDyKFrshWd1P9dZGTSuU=5P0L6LSPz=v2nn+0SWi3ZZazKrRw@mail.gmail.com>
Message-ID: <CACPK8XeOgNviNY6gBw74Kvmf=a6d8t4PRbZk1YevxUG035QxUQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2019 at 12:59, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 18 Nov 2019 at 11:47, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> >
> > Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> > bit in case of inverted card detection signal.
> >
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
>
> Applied for next, thanks!
>
> For clarity, I am leaving patch 1 for arm-soc.

Thanks. I'd already sent the aspeed pull request for 5.5, so I'll send
the device tree patch next merge window.

Cheers,

Joel
