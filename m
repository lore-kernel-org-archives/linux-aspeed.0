From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 24 Jun 2024 10:35:19 +0930
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: aspeed,ast2600-pinctrl:
 add NCSI group
In-Reply-To: <CAGfYmwWp2dayGvySdYvU+nmtxZ-x3PPW_j69ZoBD4mxzPMQAzg@mail.gmail.com>
References: <20240620084337.3525690-1-potin.lai.pt@gmail.com>
	 <20240620084337.3525690-2-potin.lai.pt@gmail.com>
	 <cb55efedaef63e4580c11415aa2e29606edcaf9f.camel@codeconstruct.com.au>
	 <CAGfYmwWp2dayGvySdYvU+nmtxZ-x3PPW_j69ZoBD4mxzPMQAzg@mail.gmail.com>
Message-ID: <25f3b4cf773f2757ec134b0e82f59a483eed28c5.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 16:53 +0800, Potin Lai wrote:
> On Fri, Jun 21, 2024 at 8:46?AM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> 
> > Can we also do this for RMII{1,2}RCLKO (and in the driver patch as
> > well)?
> > 
> The power of RMII{1,2} is 1.8v, which does not meet NCSI requirements.

Ah, thanks for catching that.

Andrew
