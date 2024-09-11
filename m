From: Andi Shyti <andi.shyti@kernel.org>
Date: Wed, 11 Sep 2024 17:57:04 +0200
Subject: [PATCH v3] i2c: aspeed: Update the stop sw state when the bus
 recovery occurs
In-Reply-To: <20240911093951.1674824-1-tommy_huang@aspeedtech.com>
References: <20240911093951.1674824-1-tommy_huang@aspeedtech.com>
Message-ID: <ljwz3zv7sakhqoeuceewmnk34igo2srfhtmbhhxqel3tgvqvou@wpvqldtoq6st>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tommy,

On Wed, Sep 11, 2024 at 05:39:51PM GMT, Tommy Huang wrote:
> When the i2c bus recovery occurs, driver will send i2c stop command
> in the scl low condition. In this case the sw state will still keep
> original situation. Under multi-master usage, i2c bus recovery will
> be called when i2c transfer timeout occurs. Update the stop command
> calling with aspeed_i2c_do_stop function to update master_state.
> 
> Fixes: f327c686d3ba ("i2c: aspeed: added driver for Aspeed I2C")
> 
> Cc: <stable@vger.kernel.org> # v4.13+
> Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
