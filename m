From: Rob Herring <robh@kernel.org>
Date: Fri, 23 Feb 2024 06:51:24 -0700
Subject: [PATCH v14 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
In-Reply-To: <20240221104025.1306227-3-billy_tsai@aspeedtech.com>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
 <20240221104025.1306227-3-billy_tsai@aspeedtech.com>
Message-ID: <170869628286.1766501.17404664389550900332.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Wed, 21 Feb 2024 18:40:24 +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

