From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Aug 2019 11:23:19 -0500
Subject: [PATCH 1/7] dt-bindings: arm: cpus: Add ASPEED SMP
In-Reply-To: <20190821055530.8720-2-joel@jms.id.au>
References: <20190821055530.8720-1-joel@jms.id.au>
 <20190821055530.8720-2-joel@jms.id.au>
Message-ID: <CAL_JsqKXUsBdZ3x+zsJdn-2yLEJSCvLFjtUdRzUwU1vi6iiHfQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2019 at 12:55 AM Joel Stanley <joel@jms.id.au> wrote:
>
> The AST2600 SoC contains two CPUs and requires the operating system to
> bring the second one out of firmware.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
