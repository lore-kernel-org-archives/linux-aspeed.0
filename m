From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed,  3 Apr 2024 12:04:04 +0200
Subject: [PATCH 1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
In-Reply-To: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
Message-ID: <171213860535.16780.4635499105199545058.b4-ty@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Sat, 09 Dec 2023 11:44:09 +0100, Krzysztof Kozlowski wrote:
> "mlx,multi-host" is using incorrect vendor prefix and is not documented.
> 
> 

These wait for ~4 months and they were not picked up. Let me know if anyone
else wants to take these.

Applied, thanks!

[1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/7da85354c4fa35b862294dbbb450baeb405b5a92
[2/4] ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/e515719c17beb9625a90039f6c45fa36d58bdda2
[3/4] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/af3deaf9bcb4571feb89a4050c7ad75de9aa8e1e
[4/4] ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/cac1c1dda6130771e06ace030b1b0ed62096a912

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
