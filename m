From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Mar 2024 10:51:00 +0100
Subject: [PATCH v2 2/4] mtd: Replace module_init with subsys_initcall
In-Reply-To: <20240319093405.39833-3-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-3-manojkiran.eda@gmail.com>
Message-ID: <4e3fbff7-6edc-4196-bc72-1095f14d0dfa@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:34, Manojkiran Eda wrote:
> While engaged in development on the espi kernel device driver[1],
> I noticed that the espi flash driver, utilizing the mtd subsystem,
> appears to initialize before the mtdcore subsystem registers the

NAK

You incorrectly ordered your call, so now to fix this you incorrectly
re-order rest of kernel. No. Fix your code to handle modules, probe
deferrals and device links.



Best regards,
Krzysztof

