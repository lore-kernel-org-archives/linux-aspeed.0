From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 1 Oct 2024 08:17:53 +0200
Subject: [PATCH 2/2] ARM: dts: assign reg to memory nodes
In-Reply-To: <20240930223550.353882-3-rosenp@gmail.com>
References: <20240930223550.353882-1-rosenp@gmail.com>
 <20240930223550.353882-3-rosenp@gmail.com>
Message-ID: <62220abe-196a-4434-a200-5e39af1d184d@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/10/2024 00:35, Rosen Penev wrote:
> Fixes dtc warnings:

What warnings?

Anyway, please list platforms where you tested this. This patch might
break several of them.

Such one huge patch, not split per subach, is another problem. There is
no reason to make it one huge chunk.


Best regards,
Krzysztof

