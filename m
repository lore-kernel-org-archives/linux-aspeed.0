From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 30 Sep 2021 10:48:53 +0100
Subject: [PATCH v7 2/5] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
In-Reply-To: <YVTik08lNtDRGn0L@robh.at.kernel.org>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-3-chiawei_wang@aspeedtech.com>
 <YVTik08lNtDRGn0L@robh.at.kernel.org>
Message-ID: <YVWIBQFZaGXbeg28@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 29 Sep 2021, Rob Herring wrote:

> On Mon, 27 Sep 2021 10:30:50 +0800, Chia-Wei Wang wrote:
> > Convert the bindings of Aspeed LPC from text file into YAML schema.
> > 
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
> >  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 188 ++++++++++++++++++
> >  2 files changed, 188 insertions(+), 157 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> > 
> 
> Applied, thanks!

Are you taking these now?

-- 
Lee Jones [???]
Senior Technical Lead - Developer Services
Linaro.org ? Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
