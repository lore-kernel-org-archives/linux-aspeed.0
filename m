From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 5 Sep 2021 15:27:38 +0100
Subject: [v5 02/15] dt-bindings: iio: adc: Add ast2600-adc bindings
In-Reply-To: <YS7ZnG05pZvfA/7m@robh.at.kernel.org>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
 <20210831071458.2334-3-billy_tsai@aspeedtech.com>
 <YS7ZnG05pZvfA/7m@robh.at.kernel.org>
Message-ID: <20210905152738.2645b531@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 31 Aug 2021 20:38:36 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, 31 Aug 2021 15:14:45 +0800, Billy Tsai wrote:
> > Add device tree bindings document for the aspeed ast2600 adc device
> > driver.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  .../bindings/iio/adc/aspeed,ast2600-adc.yaml  | 100 ++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I'm going to push on with this series until I hit anything that needs to wait
for the fix to be available.  If that happens I'll have to wait until that's
in Linus' tree before taking the rest.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to work it's magic.

Thanks,

Jonathan


