From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 21 Mar 2023 16:20:23 +0100
Subject: [PATCH v2 3/4] eeprom: ee1004: Add devicetree binding
In-Reply-To: <20230321151642.461618-4-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-4-eajames@linux.ibm.com>
Message-ID: <bad282d5-9e40-a99d-0abb-d04163dcf080@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/03/2023 16:16, Eddie James wrote:
> Add an OF match table for devicetree instantiation of EE1004
> devices.

Subject: There is no device tree binding here. You add OF matching (or
support) to the driver.

> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/misc/eeprom/ee1004.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Best regards,
Krzysztof

