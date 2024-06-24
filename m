From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 24 Jun 2024 10:41:06 +0930
Subject: [PATCH v4 2/2] pinctrl: aspeed-g6: Add NCSI pin group config
In-Reply-To: <20240621093142.698529-3-potin.lai.pt@gmail.com>
References: <20240621093142.698529-1-potin.lai.pt@gmail.com>
	 <20240621093142.698529-3-potin.lai.pt@gmail.com>
Message-ID: <3083d7243b7ec79b78f47df962f9bd6189402727.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 17:31 +0800, Potin Lai wrote:
> Based on the NCSI pin table (Table 181) in NCSI spec[1], the reference
> clock output pin (RMIIXRCLKO) is not needed on the management controller
> side.
> 
> To optimize pin usage, add new NCSI pin group that excludes RMIIXRCLKO,
> reducing the number of required pins.
> 
> LINK: [1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0a.pdf
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

