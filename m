Return-Path: <linux-aspeed+bounces-4224-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169C4CD98C6
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Jun 2026 04:06:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTbw5RC2z3bqD;
	Thu, 11 Jun 2026 14:06:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781150796;
	cv=none; b=gvL68r4cspY9LutRI0JS+KV6CPIqpTGc0we2PowOd89xYPPD9bln3taQgE40SYEoiHl0rZqgjMr/VBRy6+imh7pwaZmG4MeqCFvLafWEVwZ/dU6YlbPNrs8zpdqcrrlI64Hd2srgXCqN/SDOx14qg6zrH+7mxZxHp+x9BJczWyJFu1wwI+b9cz3n4gQ6VprFBcILpeB4QIE29rXRYKpeCz2UEOrZ4F54fvCo/qvLwyLL0CaptPBPSRskJqPHk8tfkYldGdMFa5LpZcF8HppvINL5Vc6q7H9zh8zqX/eORMsMYlsxNwXU2yZiU9PxL/wcLSQM2aqMWIcTIlPF78/igg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781150796; c=relaxed/relaxed;
	bh=fs2D/dmY6qG5eFk5keXxNf0HlHzBHntwLDPmYvPj8xA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYloIO/+d9m2nss89lD8CC6u817ZyV00EXbZrIZEH7Bim9tpjftvy8WivDVWgytpwmLzjF5aMGfd4BDeUUpmsJBwopuAlkhQdd39G0S1kGNga7SP92i+Th35Y4P5bijjWH5G3WC/RPRZt02SW1jg5dPsq5aATwiuBe2SBWzSeHiO0r7SYb1ETXLR063krwwPEELV5lNFJq9VIP3MYQxJz2F4/U1WFtBO+CFGqCjHt8vAf89G8SDINqg9jJJ+S0DGXqwj7R02WdVlgF+EQAspS+3z5cJRSrWxwpBBL85mdTutMLVAb/CfejuIlkylJs3lJI/H5mGeOCkWrIyaC4BAZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h5T9HOKS; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h5T9HOKS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTbv55jMz3bpt
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 14:06:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781150794;
	bh=fs2D/dmY6qG5eFk5keXxNf0HlHzBHntwLDPmYvPj8xA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h5T9HOKS7M9O1foYkec/z47r6o6cIhERYKZtRFocOM6fumMx01P4miGrprmiV2Qb/
	 xhYspqxpGkBpqRCPopb7HhMu4MoxDRO4y3TArJgafrGawwxg+r+LvQPhzS1uoiWgUo
	 sixF/Ww0INydYwfA+rSm828vbrRIhZHOiBhU3GPI0wjQOfQPOTCdXIvjtKUYB4E5Eb
	 JhwiYxvKlrOSHe3FohbDfZxBVPbnO7Hg6aLR1FA2IeWqPVFWRZYSej4ODOlKQvnw2e
	 MW8fX+uej6ProOA7Lpn1bTkRQ5oLrU/patSOT7Mz340qjQpfLF8TOn3uHsorLbKMUJ
	 MkuYWc7diWwZA==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CB59160A0C;
	Thu, 11 Jun 2026 12:06:32 +0800 (AWST)
Message-ID: <5543c67f4eb6a206e524c6a590e13bbb1756b0df.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/9] ARM: dts: aspeed: anacapa: restructure
 devicetree for development-phase
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: u8813345@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	colin.huang2@amd.com, Carl Lee <carl.lee@amd.com>, Rex Fu
 <rex.fu.amd@gmail.com>,  Andy Chung <Andy.Chung@amd.com>, Peter Shen
 <peter.shen@amd.com>
Date: Thu, 11 Jun 2026 13:36:32 +0930
In-Reply-To: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
References: 
	<20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Colin,

On Tue, 2026-06-02 at 21:24 +0800, Colin Huang via B4 Relay wrote:


...

>=20
> Colin Huang (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add EVT1 device=
tree and point wrapper to it
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add EVT2 device=
tree inheriting EVT1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add DVT devicet=
ree inheriting EVT2

So my concern with these three are that none of the EVT1, EVT2 or DVT
devicetrees correspond with the current Anacapa devicetree. All of them
have variations on the configured GPIOs. Some GPIO lines are renamed
while others are added.

Adding them is (eventually) fine, but I'd rather not do that while
we're shuffling the devicetree sources around.

Renaming them to accommodate changes in the one devicetree is what
we're trying to escape here, so having renames hide in the rest of the
shuffling is definitely problematic.

For example:

   -""                    =20
   +"L_FNIC_FLT"     =20
    "FM_CPU0_SYS_RESET_N"
   -""                                                                     =
                                                                           =
           =20
   +"L_BNIC0_FLT"
    "CPU0_KBRST_N"
   -""
   +"L_BNIC1_FLT"
    "FM_CPU0_PROCHOT_trigger_N"
   -""
   +"L_BNIC2_FLT"
    "FM_CLR_CMOS_R_P0"
   -""
   +"L_BNIC3_FLT"
    "Force_I3C_SEL"
   -""
   +"L_RTM_SW_FLT"
    "SYSTEM_Force_Run_AC_Cycle"
    ""
    ""
   @@ -20,55 +20,57 @@
    "FM_SCM_JTAG_MUX_SEL"
    "Channel2_leakage_Manifold1"
    "FM_BRIDGE_JTAG_MUX_SEL"
   -"Channel3_leakage"
   +"Channel5_leakage_present_EAM1"

I've pasted a script below that helps compare the various dts files.
You can use it to generate the reference from the current aspeed-bmc-
facebook-anacapa.dts, then generate the comparison files from the newly
introduced dts files.

To reiterate, I expect the shuffling of the dts files to result in at
least one of the variants producing the same devicetree as the current
aspeed-bmc-facebook-anacapa.dts.

Andrew

   #!/usr/bin/bash
  =20
   set -x
  =20
   : ${ANACAPA_VARIANT:=3D""}
   : ${ANACAPA_REFERENCE:=3D"arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-=
anacapa.dtb.rt.dts.tmp"}
  =20
   if [ -z "$ANACAPA_REFERENCE" ] || ! [ -e "$ANACAPA_REFERENCE" ]
   then
     gcc -E -Wp,-MMD,arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anacapa.=
dtb.d.pre.tmp -nostdinc -I ../scripts/dtc/include-prefixes -undef -D__DTS__=
 -x assembler-with-cpp -o arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-ana=
capa.dtb.dts.tmp ../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dt=
s ; ./scripts/dtc/dtc -o arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anaca=
pa.dtb -b 0 -i../arch/arm/boot/dts/aspeed/ -i../scripts/dtc/include-prefixe=
s -Wno-unique_unit_address -Wno-unit_address_vs_reg -Wno-avoid_unnecessary_=
addr_size -Wno-alias_paths -Wno-interrupt_map -Wno-simple_bus_reg   -d arch=
/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anacapa.dtb.d.dtc.tmp arch/arm/bo=
ot/dts/aspeed/.aspeed-bmc-facebook-anacapa.dtb.dts.tmp ; cat arch/arm/boot/=
dts/aspeed/.aspeed-bmc-facebook-anacapa.dtb.d.pre.tmp arch/arm/boot/dts/asp=
eed/.aspeed-bmc-facebook-anacapa.dtb.d.dtc.tmp > arch/arm/boot/dts/aspeed/.=
aspeed-bmc-facebook-anacapa.dtb.d
     dtc -I dts -O dts -o arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-ana=
capa.dtb.rt.dts.tmp arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anacapa.d=
tb.dts.tmp
     ANACAPA_REFERENCE=3Darch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anac=
apa.dtb.rt.dts.tmp
   fi
  =20
   if [ -n "$ANACAPA_VARIANT" ]
   then
     gcc -E -Wp,-MMD,arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anacapa-=
${ANACAPA_VARIANT}.dtb.d.pre.tmp -nostdinc -I ../scripts/dtc/include-prefix=
es -undef -D__DTS__ -x assembler-with-cpp -o arch/arm/boot/dts/aspeed/.aspe=
ed-bmc-facebook-anacapa-${ANACAPA_VARIANT}.dtb.dts.tmp ../arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-anacapa-${ANACAPA_VARIANT}.dts ; ./scripts/dtc/=
dtc -o arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-${ANACAPA_VARIA=
NT}.dtb -b 0 -i../arch/arm/boot/dts/aspeed/ -i../scripts/dtc/include-prefix=
es -Wno-unique_unit_address -Wno-unit_address_vs_reg -Wno-avoid_unnecessary=
_addr_size -Wno-alias_paths -Wno-interrupt_map -Wno-simple_bus_reg   -d arc=
h/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anacapa-${ANACAPA_VARIANT}.dtb.d=
.dtc.tmp arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anacapa-${ANACAPA_VA=
RIANT}.dtb.dts.tmp ; cat arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-anac=
apa-${ANACAPA_VARIANT}.dtb.d.pre.tmp arch/arm/boot/dts/aspeed/.aspeed-bmc-f=
acebook-anacapa-${ANACAPA_VARIANT}.dtb.d.dtc.tmp > arch/arm/boot/dts/aspeed=
/.aspeed-bmc-facebook-anacapa-${ANACAPA_VARIANT}.dtb.d
     dtc -I dts -O dts -o arch/arm/boot/dts/aspeed/.aspeed-bmc-facebook-ana=
capa-${ANACAPA_VARIANT}.dtb.rt.dts.tmp arch/arm/boot/dts/aspeed/.aspeed-bmc=
-facebook-anacapa-${ANACAPA_VARIANT}.dtb.dts.tmp
     diff -u "$ANACAPA_REFERENCE" arch/arm/boot/dts/aspeed/.aspeed-bmc-face=
book-anacapa-${ANACAPA_VARIANT}.dtb.rt.dts.tmp | tee ${ANACAPA_VARIANT}-{re=
move,add}
     grep '^-[^-]' ${ANACAPA_VARIANT}-remove | grep gpio-line-names | sed -=
E 's/.+gpio-line-names =3D //' | tr ',' '\n' | sed -E 's/^ //' | sponge ${A=
NACAPA_VARIANT}-remove
     grep '^[+][^+]' ${ANACAPA_VARIANT}-add | grep gpio-line-names | sed -E=
 's/.+gpio-line-names =3D //' | tr ',' '\n' | sed -E 's/^ //' | sponge ${AN=
ACAPA_VARIANT}-add
     diff -u ${ANACAPA_VARIANT}-{remove,add}
   fi


