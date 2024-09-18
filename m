From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 18 Sep 2024 15:03:03 +0200
Subject: [PATCH v2 1/3] dt-bindings: trivial-devices: support pmbus
 compatible string
In-Reply-To: <20240918095438.1345886-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
 <20240918095438.1345886-2-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <e94f03a9-92e1-47d5-aa36-fc51216436c9@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/09/2024 11:54, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Add pmbus compatibale string for the Generic PMbus devices that could
> be monitor by pmbus driver.
> 

You need to explain more, provide background why we would like to accept
a generic compatible. And why a specific compatible cannot or should not
be used...

In general this is a no, you cannot have such compatibles for real hardware.

Best regards,
Krzysztof

