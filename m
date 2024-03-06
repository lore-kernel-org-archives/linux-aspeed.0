From: Andi Shyti <andi.shyti@kernel.org>
Date: Wed, 06 Mar 2024 12:55:41 +0100
Subject: [PATCH v2] i2c: aspeed: Fix the dummy irq expected print
In-Reply-To: <20240305011906.2745639-1-tommy_huang@aspeedtech.com>
References: <20240305011906.2745639-1-tommy_huang@aspeedtech.com>
Message-ID: <170972614153.1712532.8035778125665215281.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

On Tue, 05 Mar 2024 09:19:06 +0800, Tommy Huang wrote:
> When the i2c error condition occurred and master state was not
> idle, the master irq function will goto complete state without any
> other interrupt handling. It would cause dummy irq expected print.
> Under this condition, assign the irq_status into irq_handle.
> 
> For example, when the abnormal start / stop occurred (bit 5) with
> normal stop status (bit 4) at same time. Then the normal stop status
> would not be handled and it would cause irq expected print in
> the aspeed_i2c_bus_irq.
> 
> [...]

Applied to i2c/i2c-host-fixes on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: aspeed: Fix the dummy irq expected print
      commit: 94e889260a5bae7d4c06de90f1724aeb8b1175c6

