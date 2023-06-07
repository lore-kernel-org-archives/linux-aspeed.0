From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 7 Jun 2023 10:33:57 +0200
Subject: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <SG2PR06MB33657063A2E3239AD0A21F718B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
 <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <742d3161-3a4d-ea77-7bd4-85f6636bf400@linaro.org>
 <SG2PR06MB33657063A2E3239AD0A21F718B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <2af1bc5b-0be6-46cc-3155-307f13fbba11@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/06/2023 10:32, Billy Tsai wrote:
> Ok, I got it. I will remove usage of the simple-mfd and parent node in next version of the patch.
> Thanks
> 

1. Whether parent node stays or not, depends on the hardware. Please do
not make random changes which do not correspond to the hardware.

2. Implement all, *all* the comments from previous discussions, not only
this one.

Best regards,
Krzysztof

