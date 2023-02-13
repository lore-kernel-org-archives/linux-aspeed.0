From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 09:44:52 +0100
Subject: [PATCH v2 2/3] clk: aspeed: Add full configs for i3c clocks
In-Reply-To: <5ee4ade6820a9db8dc9c20bb39fd8a4c4cd7c2a6.1676267865.git.jk@codeconstruct.com.au>
References: <cover.1676267865.git.jk@codeconstruct.com.au>
 <5ee4ade6820a9db8dc9c20bb39fd8a4c4cd7c2a6.1676267865.git.jk@codeconstruct.com.au>
Message-ID: <d0919faa-63ef-0957-afb4-543a05864fc9@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 07:02, Jeremy Kerr wrote:
> The current ast2600 i3c clock definitions are top-level (rather than
> based on their actual hw sources: either HCLK or APLL), and include a
> couple of definitions for (non-existent) i3c6 and i3c7.

Why do you use subject prefix in patch 1 different than in patch 2?

Best regards,
Krzysztof

