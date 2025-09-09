Return-Path: <linux-aspeed+bounces-2178-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DA4CA0FED
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Sep 2025 08:41:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLck13vvlz30V1;
	Tue,  9 Sep 2025 18:41:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757407289;
	cv=none; b=Zi31F0BclhEYq7+jfTzCCZCF35scbZ3eCVaoPS2T2liU05tc8ZYHANWK6stdDorf5hK/oXLYvAucOwJiSsk+3XR+JMWmqxK5MywHoHwJkWJVp+tGLTLf0J20VX60SIJjPgRmLhh7TYbM6GHzkg4LZj4KEi1afw5avQbDTNdXGDB+ysiENeVZUvM9oP7+073B6jmVouDyjE3QJV5W1b2ClBTh1wYbjBsMD0d0JlKYvNEfDW8YSq68anrA77YyAVg4zsdL7NzdzEQ21+BGZUd7NoDUWohVE2BEnsaFmlE+qU7uN1DTOOSsM1hdxKLmk+feQGEM0b7sC5qPJArH+S7nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757407289; c=relaxed/relaxed;
	bh=U7ePnYmOtqTHJjolMf4hlSRaTCGH9Xh1EcH3rMZqHlc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SsMTWPhCmhxeeZqRLsA+ZdBmXItFIUcgBZXTj/BvReOoQfAwwu5Sh2bLck6YbJr/3HXS553doFH39LzTjLrZEvWU44ZCXGkCYt6y77Xq/TRuyP9X+3cAGSIMCXf/4BMEAoQ7QRQT0NAJ9Aha2YV65SsqEAqtRGt/0RDp5xih2vtMybdpI07HdUgccAahGmLIi1Z+rbSejcfO5GyxgPmBNZwIsNHiUnvHE2HiH1OWWr8fNAfalxZB32mhyxzrBjn8SSGnbEgPaGd/xqSWByKfgN7HpMsNmCPD4J6nUm6YeAOD+SUzWXaxSBjrfNdH4Eoh5vkV7X5/OyNnGFdfJqkzZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Sd92CweD; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Sd92CweD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLcjz3Pzkz30Ff
	for <linux-aspeed@lists.ozlabs.org>; Tue,  9 Sep 2025 18:41:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757407284;
	bh=U7ePnYmOtqTHJjolMf4hlSRaTCGH9Xh1EcH3rMZqHlc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sd92CweDx23fukVxldZRkSELHkaUqB8ZI6EDJP1uvQmfLhLM/4VikWAhtALLzUjRi
	 0KFWWhA9B/3yNtWrdWjO8qrY4FVG/gRgOy1Qu/bq+3kgJX7WUDrYrHvgiXyOJ0Itrx
	 mx+k1uTk/73Xfhirp8eicIL3NH3C8s3zglU+zsGkOTC70DwRowHAl6Va1Rhembxr7J
	 i+lOBXo5Sad2n1JS/JaLZwxb5daStYSsnvx9Nr1TfADjiKtWu3BlTAsAE1ENPmXb+6
	 s+3/y/l0X536QqP/R3yYiHm3D+uzKnIvPx8Ga+Dn6sqoX2LzHmCi/zffMqVHspJfus
	 uQsKAyx4EdoRQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 08FD36443C;
	Tue,  9 Sep 2025 16:41:21 +0800 (AWST)
Message-ID: <1a2ca78746e00c2ec4bfc2953a897c48376ed36f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent compatibles and refine documentation
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Kevin Chen <kevin_chen@aspeedtech.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Tue, 09 Sep 2025 18:11:19 +0930
In-Reply-To: <20250814-auspicious-thundering-jaybird-b76f4f@kuoka>
References: <20250812100830.145578-1-ryan_chen@aspeedtech.com>
	 <20250812100830.145578-2-ryan_chen@aspeedtech.com>
	 <20250814-auspicious-thundering-jaybird-b76f4f@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2025-08-14 at 10:03 +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 12, 2025 at 06:08:29PM +0800, Ryan Chen wrote:
> > AST2700 contains two independent top-level interrupt controllers (INTC0=
,
> > INTC1). Each occupies its own register space and handles different sets=
 of
> > peripherals. Above them, the PSP (CA35) GIC is the root interrupt
> > aggregator. In hardware, INTC1 outputs are routed into INTC0, and INTC0
> > outputs are routed into the GIC.
> >=20
> > Introduce distinct compatibles for these parent blocks so the DT can mo=
del
> > the hierarchy and register space layout accurately:
> >=20
> > =C2=A0 - aspeed,ast2700-intc0=C2=A0 (parent node at 0x12100000)
> > =C2=A0 - aspeed,ast2700-intc1=C2=A0 (parent node at 0x14c18000)
> >=20
> > The existing child compatible:
> >=20
> > =C2=A0 - aspeed,ast2700-intc-ic
> >=20
> > continues to describe the interrupt-controller instances within each IN=
TC
> > block (e.g. INTC0_0..INTC0_11 and INTC1_0..INTC1_5).
> >=20
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> > =C2=A0.../aspeed,ast2700-intc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 158 ++=
+++++++++++-----
> > =C2=A01 file changed, 115 insertions(+), 43 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2700-intc.yaml
> > b/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2700-intc.yaml
> > index 55636d06a674..81304b53c112 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast=
2700-intc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast=
2700-intc.yaml
> > @@ -10,6 +10,33 @@ description:
> > =C2=A0=C2=A0 This interrupt controller hardware is second level interru=
pt controller that
> > =C2=A0=C2=A0 is hooked to a parent interrupt controller. It's useful to=
 combine multiple
> > =C2=A0=C2=A0 interrupt sources into 1 interrupt to parent interrupt con=
troller.
> > +=C2=A0 Depend to which INTC0 or INTC1 used.
> > +=C2=A0 INTC0 and INTC1 are two kinds of interrupt controller with enab=
le and raw
> > +=C2=A0 status registers for use.
> > +=C2=A0 INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> > +=C2=A0 INTC1 is used to assert INTC0 if interrupt of modules asserted.
> > +=C2=A0 +-----+=C2=A0=C2=A0 +---------+
> > +=C2=A0 | GIC |---|=C2=A0 INTC0=C2=A0 |
> > +=C2=A0 +-----+=C2=A0=C2=A0 +---------+
>=20
> Same problem as last time. This tells me intc0 has not children...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--=
-------+
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |---module0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | I=
NTC0_0 |---module1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |---...
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--=
-------+---module31
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |--=
-....=C2=A0 |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--=
-------+
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 =
+---------+
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | I=
NTC0_11| +---| INTC1=C2=A0=C2=A0 |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 =
+---------+
>=20
> ...This tells that inc1 has no children (only intc0_11, which you said
> is aspeed,ast2700-intc-ic !!!)....
> (keep scrolling)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--=
-------+=C2=A0=C2=A0=C2=A0=C2=A0 +---------+---module0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | INTC1_0 |---module1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |---..=
.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +---------+---module31
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ...
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +---------+---module0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | INTC1_5 |---module1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |---..=
.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +---------+---module31
> > =C2=A0

I've taken a look at the datasheet and had a bit of a think about how
to make progress here.=C2=A0

My feeling is this diagram (and the previous one) undersells the
complexity of the design by quite some margin. It's probably best to
start by zooming out quite a lot:

The AST2700 SoC contains (at least) 4 distinct processors:

1. The quad-core ARM Cortex-A35 (PSP: Primary Service Processor)
2. A Cortex-M4 (SSP: Secondary Service Processor)
3. Another Cortex-M4 (TSP: Tertiary Service Processor)
4. The BootMCU - a RISC-V processor to execute the mask ROM

While the PSP GIC shown in the diagram above is one possible interrupt
destination, many of the 480 interrupt sources in the package can be
routed to the dedicated interrupt controller of any of these four
processors. Likewise, many peripherals of the SoC are mapped into the
physical address space of each processor. The routing is handled by the
two interrupt controller blocks described in the binding text above:

+--------------------+
| +-------+ +------+ |
| |       | |      | |
| |  PSP  +-+ GIC  <-+----------+
| |       | |      | |          |
| +-------+ +------+ |          |
+--------------------+          |
                                |
+--------------------+          |
| +-------+ +------+ |          |          +-------+
| |       | |      | |          |          |       |   INTx
| |  SSP  +-+ NVIC <-+----------+----------| INTC0 <-----------
| |       | |      | |          |          |       |
| +-------+ +------+ |          |          +---^---+
+--------------------+          |              |
                                |              |
+--------------------+          |              |
| +-------+ +------+ |          |              |
| |       | |      | |          |              |
| |  TSP  +-+ NVIC <-+----------+              |
| |       | |      | |                         |
| +-------+ +------+ |                         |
+--------------------+                         |
                                               |
+--------------------+                         |
| +------+ +-------+ |                     +---+---+
| |      | |       | |                     |       |   INTy
| | BMCU +-+ APLIC <-+---------------------+ INTC1 <-----------
| |      | |       | |                     |       |
| +------+ +-------+ |                     +-------+
+--------------------+

There's a split in the interrupt domain: 0 <=3D INTx <=3D 127 < INTy.

The PSP GIC, SSP NVIC and TSP NVIC destinations for each INTx source is
selected by a corresponding mux in INTC0.

The destination for each INTy source is selected by a corresponding mux
in INTC1, where the possible destinations are:

1. A shared interrupt line Ma, routed through INTC0 to the PSP GIC
2. A mux in INTC0, providing a second level of indirection
3. A shared interrupt line Md, routed through INTC0 to the PSP GIC
4. A shared interrupt line Me, routed through INTC0 to the PSP GIC
5. A shared interrupt line Mb, routed through INTC0 to the SSP NVIC
6. A shared interrupt line Mc, routed through INTC0 to the TSP NVIC
7. The BootMCU APLIC

Each shared interrupt line from INTC1 to INTC0 merges up to 32
interrupt sources.

INTC0 and INTC1 are both mapped into the physical address space of each
processor. However, to prevent any one of them interfering with
interrupts dedicated to another, the controller's register map is
divided into distinct regions whose access is constrained to a specific
processor. The enable and status registers in INTC0 for shared line
sets Ma, Md and Me are constrained to the PSP, Mb to the SSP, and Mc to
the TSP.

                                   +-------+            +-------+
                                   | INTC0 |            | INTC1 |
- - - - - - - - - - - - - - - - - -+- - - -+- - - - - - +- - - -+- -
  +--------------------+           |       |            |       |
  | +-------+ +------+ |           |       |            |       |
  | |       | |      | |           |       |            |       |
  | |  PSP  +-+ GIC  | |           |       |            |       |
  | |       | |      | |           |       |            |       |
  | +-------+ |      | |           |       |            |       |
  |           |      | |           +-------+            |       |
  |           |  192 <-|-----------+  Ma   <------------|---+   |
  |           |      | |           +-------+            |   |   |
  |           |  208 <-|-----------+  Md   <------------|---+   |
  |           |      | |           +-------+            |   |   |
  |           |  224 <-|-----------+  Me   <------------|---+   |
  |           |      | |           +-------+            |   |   |
  |           +------+ |           |       |            |   |   |
  +--------------------+           |       |            |   |   |
- - - - - - - - - - - - - - - - - -+- - - -+- - - - - - +- -|- -+- -
  +--------------------+           |       |            |   |   |
  | +-------+ +------+ |           +-------+            |   +---|----------=
--
  | |  SSP  +-+ NVIC <-|-----------+  Mb   <------------|---+   |   INT128
  | +-------+ +------+ |           +-------+            |   |   |
  +--------------------+           |       |            |   |   |
- - - - - - - - - - - - - - - - - -+- - - -+- - - - - - +- -|- -+- -
  +--------------------+           |       |            |   |   |
  | +-------+ +------+ |           +-------+            |   |   |
  | |  TSP  +-+ NVIC <-|-----------+  Mc   <------------|---+   |
  | +-------+ +------+ |           +-------+            |       |
  +--------------------+           |       |            |       |
- - - - - - - - - - - - - - - - - -+- - - -+- - - - - - +- - - -+- -
  +--------------------+           |       |            |       |
  | +------+ +-------+ |           |       |            |       |
  | | BMCU +-+ APLIC | |           |       |            |       |
  | +------+ +-------+ |           |       |            |       |
  +--------------------+           |       |            |       |
- - - - - - - - - - - - - - - - - -+- - - -+- - - - - - +- - - -+- -
                                   +-------+            +-------+


INTC1 mux destination 2 above allows the PSP to reconfigure the routes
at runtime at INTC0, rather than submit to a route that might've been
protected by firmware early in the boot chain, so long as the boot
firmware chose the appropriate route in INTC1. INTC0 merges these
interrupts in sets of 32 and operates in much the same way as INTC1 in
the diagram above, though cannot route to the BootMCU.

I'd prefer we acknowledge all this in the binding, and do enough to
allow the kernel to configure routing as it wishes. While in some
applications the routes may be constrained by firmware, the platform-
specific portion of the devicetree can be written reflect this.

From some experimentation this shouldn't require anything bespoke.
Using interrupts-extended we can represent the route configuration with
a phandle to the upstream controller on the cascaded node. To avoid
some arbitrary interrupt index choices at the node for INTC0, I think
it's worth describing the register sets for interrupt sets Ma, Md and
Me as subnodes of INTC0 with their own interrupt resources. This feels
reasonably tidy, as the selection of the Ma, Md or Me sets completely
determines its ultimate index at the PSP GIC. Doing so also removes
them from needing to be described if any changes to some default route
configuration are required by the platform, necessitating overriding
the interrupts-extended property of the INTC0 node.

The only curiosity of this approach is that the interrupt-controller
nodes for the non-PSP processors need to be described so we can
reference them via phandles for the purpose of routing the interrupts.
As these controllers are not mapped in the physical address space of
the PSP we need the devicetree to inform the kernel as much.

Here's an example pseudo-devicetree. Of course there are elements that
need more work, but I feel we can mine it for parts.

Cheers,

Andrew

/ {
  primary {
    compatible =3D "simple-bus";
    #address-cells =3D <1>;
    #size-cells =3D <1>;
    ranges;

    intc0: interrupt-controller@12100000 {
      compatible =3D "aspeed,ast2700-intc0-a1";
      reg =3D <0x12100000 0x1b00>;
      #address-cells =3D <1>;
      #size-cells =3D <1>;
      ranges;
      interrupt-controller;
      #interrupt-cells =3D <2>;
      interrupts-extended =3D
#if GIC
        /* GICINT0   */ <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
#elif SSP
        /* SSPINT0   */ <&ssp_nvic 0 0>,
#else /* TSP */
        /* TSPINT0   */ <&tsp_nvic 0 0>,
#endif

        /* ... */

#if GIC_128 /* Route merged 128-159 interrupts to GICINT128 */
        /* 128 */ <&gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
#elif GIC_160 /* Route merged 128-159 interrupts to GICINT160 */
        /* 128 */ <&gic GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
#elif GIC_176 /* Route merged 128-159 interrupts to GICINT176 */
        /* 128 */ <&gic GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
#elif SSP
        /* 128 */ <&ssp_nvic 128 0>,
#else /* TSP */
        /* 128 */ <&tsp_nvic 128 0>,
#endif

        /* ... */

        /* 186 */ <&gic 186 0>;

      intcm0: interrupt-controller@12101b00 {
        compatible =3D "aspeed,ast2700-intcm-a1";
        reg =3D <0x12101b00 0x10>;
        interrupt-controller;
        #interrupt-cells =3D <2>;
        interrupt-parent =3D <&gic>;
        interrupts =3D
          <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
      };

      intcm30: interrupt-controller@12101b10 {
        compatible =3D "aspeed,ast2700-intcm-a1";
        reg =3D <0x12101b10 0x10>;
        interrupt-controller;
        #interrupt-cells =3D <2>;
        interrupt-parent =3D <&gic>;
        interrupts =3D
          <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
      };

      intcm40: interrupt-controller@12101b20 {
        compatible =3D "aspeed,ast2700-intcm-a1";
        reg =3D <0x12101b20 0x10>;
        interrupt-controller;
        #interrupt-cells =3D <2>;
        interrupt-parent =3D <&gic>;
        interrupts =3D
          <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
          <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
          <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
      };
    };

    intc1: interrupt-controller@14c18000 {
      compatible =3D "aspeed,ast2700-intc1-a1";
      reg =3D <0x14c18000 0x1000>;
      interrupt-controller;
      #interrupt-cells =3D <2>;
      interrupts-extended =3D
#if M0
        /* 0   */ <&intcm0 0 IRQ_TYPE_LEVEL_HIGH>,
#elif C0
        /* 0   */ <&intc0 128 IRQ_TYPE_LEVEL_HIGH>,
#elif M10
        /* 0   */ <&ssp_nvic 160 0>,
#elif M20
        /* 0   */ <&tsp_nvic 160 0>,
#elif M30
        /* 0   */ <&intcm30 0 IRQ_TYPE_LEVEL_HIGH>,
#elif M40
        /* 0   */ <&intcm40 0 IRQ_TYPE_LEVEL_HIGH>,
#else /* B */
        /* 0   */ <&aplic 128 IRQ_TYPE_LEVEL_HIGH>,
#endif
        /* ... */
    };

    vuart1: serial@1e787000 {
      compatible =3D "aspeed,ast2700-vuart";
      reg =3D <0x14c30000 0x1000>;
      reg-shift =3D <2>;
      interrupts-extended =3D <&intc1 17 IRQ_TYPE_LEVEL_HIGH>;
    };

    gic: interrupt-controller@fff01000 {
      compatible =3D "arm,gic-400";
      #interrupt-cells =3D <3>;
      #address-cells =3D <0>;
      interrupt-controller;
      reg =3D <0x0 0xfff01000 0 0x1000>,
            <0x0 0xfff02000 0 0x2000>,
            <0x0 0xfff04000 0 0x2000>,
            <0x0 0xfff06000 0 0x2000>;
      interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HI=
GH)>;
    };
  };

  secondary {
    #address-cells =3D <2>;
    /* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/of/address.c?h=3Dv6.16#n491 */
    #size-cells =3D <0>;
    /* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/of/address.c?h=3Dv6.16#n430 */

    ssp_nvic: interrupt-controller@1,e000e100 {
      compatible =3D "arm,v7m-nvic";
      #interrupt-cells =3D <2>;
      #address-cells =3D <0>;
      interrupt-controller;
      reg =3D <1 0xe000e100>;
    };
  };

  tertiary {
    #address-cells =3D <2>;
    #size-cells =3D <0>;

    tsp_nvic: interrupt-controller@2,e000e100 {
      compatible =3D "arm,v7m-nvic";
      #interrupt-cells =3D <2>;
      #address-cells =3D <0>;
      interrupt-controller;
      reg =3D <2 0xe000e100>;
    };
  };

  bootmcu {
    #address-cells =3D <2>;
    #size-cells =3D <0>;

    aplic1: interrupt-controller@3,d000000 {
      compatible =3D "riscv,aplic";
      interrupts-extended =3D <&cpu1_intc 9>,
      reg =3D <3 0xd000000>;
      interrupt-controller;
      #interrupt-cells =3D <2>;
      riscv,num-sources =3D <480>;
    };
  };
};

