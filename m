From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 2 Nov 2022 17:31:08 -0400
Subject: [v3 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <20221102083601.10456-2-billy_tsai@aspeedtech.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-2-billy_tsai@aspeedtech.com>
Message-ID: <2854316e-0874-c8f7-b090-96217dd4a4e5@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/11/2022 04:35, Billy Tsai wrote:
> This patch adds device binding for aspeed pwm-tach device which is a
> multi-function device include pwm and tach function and pwm/tach device
> bindings which should be the child-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 48 ++++++++++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 76 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 64 ++++++++++++++++
>  3 files changed, 188 insertions(+)

You sent several versions and still did not Cc me...

My previous feedback applies.

Best regards,
Krzysztof

