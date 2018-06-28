From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:42:20 +0930
Subject: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
In-Reply-To: <20180626232605.13420-12-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-12-benh@kernel.crashing.org>
Message-ID: <CACPK8Xc6zRXUzEyde=A2m8U2mzaeNMu8w=XFW77-5_uJgW3EgQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This isn't per-se a real device, it's a pseudo-device that
> represents the use of the Aspeed built-in ColdFire to
> implement the FSI protocol by bitbanging the GPIOs instead
> of doing it from the ARM core.
>
> Thus it's a drop-in replacement for the existing
> fsi-master-gpio pseudo-device for use on systems for which
> a corresponding firmware file exists. It has most of the
> same properties, plus some more needed to operate the
> coprocessor.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>
