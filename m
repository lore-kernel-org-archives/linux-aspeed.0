From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 12:04:15 +0200
Subject: [PATCH v16 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
In-Reply-To: <20240906092438.1047225-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906092438.1047225-2-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <e89bf774-12e3-4360-919e-f93148ce3456@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 11:24, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Revise Yosemite 4 devicetree for devices behind i2c-mux
> - Add gpio and eeprom behind i2c-mux
> - Remove redundant idle-state setting for i2c-mux
> - Revise address of max31790 devices after i2c-mux.
> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Missing SoB. On all your patchsets.

Best regards,
Krzysztof

