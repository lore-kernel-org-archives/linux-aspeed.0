Return-Path: <linux-aspeed+bounces-1217-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2742C3ABD8
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 May 2025 12:16:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyC400LkWz2xGF;
	Wed, 14 May 2025 22:16:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747224959;
	cv=none; b=Q46HoFeQAS2eBMiTZW0WVkDIBATnwGd2DA08CuDiBO3SXBzrSXWn7SAreyPQWyqlZaBioa+BkQd9a23zZojM1/iq8MOSsohecC0hB9PXeLUMdMRUGkKTT+Eo+z0Aau6lKh3UuwiHlVQ3CxIcKXloavsNsfot7AsnoDP09q1xh3mtvogIegnvwQzp5N9lqhShroLWaW6TAk0tnxgG3WVYBX1OLcCItr3UxFRcYFJt6KSI9YNHghq8efXddlU3xTWHGVZzCUMc7jQb9u/3jmz7rWzfP3LoERHO+agdJdNi1UZT0x4KRB8r+On9dP2NoLOP21p2UZz91GlzdFLYKqPREg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747224959; c=relaxed/relaxed;
	bh=ORW6eIowOY/CKOKK59kW1VnZw09WfBXRIX1Sk9nHmU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNupj2eY5mUl6wKxsMhkTl9dhSBrTT5WSu0ks1Uher5JBveFC8Tt1W4YghrFm5WyQfXatBFrq5csMZ+1PuHiTcGN5phvZXb/nTLynDLyzlQulWxDJccMI4YixLsCz/juPk3b2hQGZGia+DKdWFoyIvPmAVmmV/sFI3DfBAHOxfeZGQxClbwUXaACdP6N1RO9vN73el+Wi+BCTmHr4/0V/NJ7+fa3QNn1wrxRWKkNkzotzEURhXDPbZdt1xUjorGV4DIJRyKEs/lFslV3N6H/axXN4QytLx8rUYd7ZRYsTc87Kd1tv8pq48dxAGV3sYQt7vbKuLhkkZwQ0AytO9aRLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M1+cQeMW; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M1+cQeMW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyC3y6bSmz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 May 2025 22:15:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3773F61166
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 May 2025 12:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB68DC4CEE9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 May 2025 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747224955;
	bh=9n/gNZw600QYUrMnwKTPNOK3/L5E5TG7yt1bw6N/svI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M1+cQeMWeqFSPExhk2kOfMFngdVAt2HwSd0ZJmBOWDHDUThPSte3saMbGGulfctDJ
	 i/XCbsgPEM4LsgCVmUC9QzhzQykraXRWS/gHvf1/uVlcbZwGzB6oDBhN/92wtzZyDd
	 /IzEFqyUKVDUCcxb/r4PCSBzemRYF614GYWprujtb8M75/CUlHuIg2foxNfqmuCBhb
	 Pqc/HQABYG2NHFKteOho680MSX6ZxrytZJ8l3/9hwFTCbiPKUAN2mtO4OdzcHiTyJs
	 mXsF4vvWGLZZwocs3tqbiwD+xdHdRq93qA9uZctVGww5Zil5HdlvhPb3mzoWavJMoC
	 vLLS3+y0k6rHg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so1022824866b.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 May 2025 05:15:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkV+2xDdhTKxNqEgOhBmjA4fGA4L2v9xvT8C/+f/ZIQ4QropqLyHODbIAas/3s/C5FFUcFdVNHFn33cDA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPn6y705FYRiy6olWFBJmihGJDvHD56+szTUlPdjDAlsTo3r8L
	iCFmZrOUD+HPsWVer+TMGAQ3y98/FkSc8mNgVpPBYEM/w04ytNgVffEubDiGE+6xnfoOx2oC6ls
	wMbWZGMkqpsEcbTzcr1uE0nUTyg==
X-Google-Smtp-Source: AGHT+IFNbUCzY9o57wMu/2S9u0Ncn14dOvkR5s246HZBkwluWFPiNZ8XXqpaD0331VMZ5nRZZ+nBtsn19B0XOLtHKws=
X-Received: by 2002:a17:907:9488:b0:ad2:4fa0:88d1 with SMTP id
 a640c23a62f3a-ad4f70d3335mr289668866b.9.1747224954458; Wed, 14 May 2025
 05:15:54 -0700 (PDT)
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
References: <20250505144613.1287360-1-robh@kernel.org> <34dcdbd4fb15a988f15e812faa566b32506a2f2f.camel@codeconstruct.com.au>
In-Reply-To: <34dcdbd4fb15a988f15e812faa566b32506a2f2f.camel@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 14 May 2025 07:15:42 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8k=7+zV6v4KEws0VNRt5pJYyuSNkNDU=d8neriCcKLQ@mail.gmail.com>
X-Gm-Features: AX0GCFshp9fzygWtFgg9ShuDUbXUnQtrRdwSG1FTt2nCPz1p1tunvy0s6IbfukQ
Message-ID: <CAL_Jsq+8k=7+zV6v4KEws0VNRt5pJYyuSNkNDU=d8neriCcKLQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 aspeed,ast2xxx-scu-ic to DT schema
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Eddie James <eajames@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Lee Jones <lee@kernel.org>, Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:26=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Rob,
>
> Thanks for the conversion. One comment below:
>
> On Mon, 2025-05-05 at 09:46 -0500, Rob Herring (Arm) wrote:
> > Convert the Aspeed SCU interrupt controller binding to schema format.
> > It's a straight-forward conversion of the typical interrupt
> > controller.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  .../aspeed,ast2500-scu-ic.yaml                | 48
> > +++++++++++++++++++
> >  .../aspeed,ast2xxx-scu-ic.txt                 | 23 ---------
> >  .../bindings/mfd/aspeed,ast2x00-scu.yaml      |  9 +++-
> >  MAINTAINERS                                   |  2 +-
> >  4 files changed, 57 insertions(+), 25 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2500-scu-ic.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2xxx-scu-ic.txt
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2500-scu-ic.yaml
> > b/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2500-scu-ic.yaml
> > new file mode 100644
> > index 000000000000..d5287a2bf866
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2500-scu-ic.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2025 Eddie James
> > +%YAML 1.2
> > +---
> > +$id:
> > http://devicetree.org/schemas/interrupt-controller/aspeed,ast2500-scu-i=
c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed AST25XX and AST26XX SCU Interrupt Controller
> > +
> > +maintainers:
> > +  - Eddie James <eajames@linux.ibm.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2500-scu-ic
> > +      - aspeed,ast2600-scu-ic0
> > +      - aspeed,ast2600-scu-ic1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#interrupt-cells'
> > +  - interrupts
> > +  - interrupt-controller
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    interrupt-controller@18 {
> > +        compatible =3D "aspeed,ast2500-scu-ic";
> > +        reg =3D <0x18 0x4>;
> > +        #interrupt-cells =3D <1>;
> > +        interrupts =3D <21>;
> > +        interrupt-controller;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2xxx-scu-ic.txt
> > b/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2xxx-scu-ic.txt
> > deleted file mode 100644
> > index 251ed44171db..000000000000
> > --- a/Documentation/devicetree/bindings/interrupt-
> > controller/aspeed,ast2xxx-scu-ic.txt
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -Aspeed AST25XX and AST26XX SCU Interrupt Controller
> > -
> > -Required Properties:
> > - - #interrupt-cells            : must be 1
> > - - compatible                  : must be "aspeed,ast2500-scu-ic",
> > -                                 "aspeed,ast2600-scu-ic0" or
> > -                                 "aspeed,ast2600-scu-ic1"
> > - - interrupts                  : interrupt from the parent
> > controller
> > - - interrupt-controller                : indicates that the
> > controller receives and
> > -                                 fires new interrupts for child
> > busses
> > -
> > -Example:
> > -
> > -    syscon@1e6e2000 {
> > -        ranges =3D <0 0x1e6e2000 0x1a8>;
> > -
> > -        scu_ic: interrupt-controller@18 {
> > -            #interrupt-cells =3D <1>;
> > -            compatible =3D "aspeed,ast2500-scu-ic";
> > -            interrupts =3D <21>;
> > -            interrupt-controller;
> > -        };
> > -    };
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-
> > scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-
> > scu.yaml
> > index c800d5e53b65..12986ebe7ec7 100644
> > --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > @@ -48,8 +48,15 @@ properties:
> >
> >  patternProperties:
> >    '^p2a-control@[0-9a-f]+$':
> > -    description: See Documentation/devicetree/bindings/misc/aspeed-
> > p2a-ctrl.txt
> >      type: object
> > +    additionalProperties: true
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          enum:
> > +            - aspeed,ast2500-scu-ic
> > +            - aspeed,ast2600-scu-ic0
> > +            - aspeed,ast2600-scu-ic1
>
> This change should be done on the interrupt-controller pattern property
> node rather than the p2a-controller node.

Indeed, I fixed it up when applying.


Rob

