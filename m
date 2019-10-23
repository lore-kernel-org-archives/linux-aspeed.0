From: Joel Stanley <joel@jms.id.au>
Date: Wed, 23 Oct 2019 06:23:53 +0000
Subject: [PATCH] EDAC: Aspeed: Use devm_platform_ioremap_resource() in
 aspeed_probe()
In-Reply-To: <baabb9e9-a1b2-3a04-9fb6-aa632de5f722@web.de>
References: <baabb9e9-a1b2-3a04-9fb6-aa632de5f722@web.de>
Message-ID: <CACPK8XfUJ5VGpTS3gwxSVZbdWZKPH6PwT2JKGGJ2yzoXYKdtZg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 21 Sep 2019 at 16:47, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Sep 2019 18:32:46 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Joel Stanley <joel@jms.id.au>
