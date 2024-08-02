From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 2 Aug 2024 11:16:17 +0200
Subject: [PATCH v2 4/9] clk: ast2700: add clock controller
In-Reply-To: <20240802090544.2741206-6-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-6-kevin_chen@aspeedtech.com>
Message-ID: <7a1769a0-7273-4995-863a-5db9e201c4f0@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/08/2024 11:05, Kevin Chen wrote:
> Add support for ast2700 clock controller.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  drivers/clk/Makefile      |    1 +
>  drivers/clk/clk-ast2700.c | 1173 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 1174 insertions(+)
>  create mode 100644 drivers/clk/clk-ast2700.c

Missing bindings.

Best regards,
Krzysztof

