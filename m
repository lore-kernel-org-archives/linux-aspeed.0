From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 23 Sep 2024 09:55:45 +0930
Subject: [PATCH] ARM: dts: aspeed: catalina: add
 i2c-mux-idle-disconnect to all mux
In-Reply-To: <20240920-catalina-i2c-mux-fix-2-v1-1-66cce7c54188@gmail.com>
References: <20240920-catalina-i2c-mux-fix-2-v1-1-66cce7c54188@gmail.com>
Message-ID: <172705114554.52616.12455513368806035629.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 17:55:52 +0800, Potin Lai wrote:
> Add the `i2c-mux-idle-disconnect` property to all i2c-mux nodes to
> ensure proper behavior when switching between multiple I2C buses.
> This avoids potential confusion caused by device addresses appearing on
> multiple buses when they are not actively selected.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>

