From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Jun 2022 05:36:58 +0000
Subject: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
In-Reply-To: <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-2-krzysztof.kozlowski@linaro.org> <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
Message-ID: <CACPK8Xc=dmaJtLXGsQa8bBdWDnSbwyW3f_yaQr4HqT0WvyScRg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 20 Jun 2022 at 11:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
> > Document all compatibles used in existing upstreamed Aspeed AST2400,
> > AST2500 and AST2600 based boards.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>
> Joel, Andrew,
>
> Any comments on the series? Rob applied only patch 1, so the rest is
> supposed through Aspeed tree. Shall I pick them up and send to arm-soc?

I will take a look at them when it's time to send patches for the next
kernel release.

They should go through the aspeed tree like the rest of the aspeed
device tree patches.

Thanks,

Joel

>
> Best regards,
> Krzysztof
