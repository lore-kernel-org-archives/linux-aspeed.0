Return-Path: <linux-aspeed+bounces-4218-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0F2CD8CB9
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 13:04:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5Zf4Kc5z2yfD;
	Wed, 10 Jun 2026 23:04:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781096650;
	cv=none; b=B0FgUB7XCvhA0/eGYVfOgHBlM/GdG2aZKohmsqpdFYvA2xrmk70b6KGyNxo0ENsWb4DMP7fPsCvJNCbUG+drqX/Cf8VH2KeUuoXfaHvNS5IAvWpQ0vvalzsGuEv5FfdVCKLs5BC3uBOIimh7VomqDB489PdH8pKmwDQjOWPQ8D803idO6ntBchVUHoRnrxCDQwdKjOaE4HRMqZoRVGFelldA+C5/YEfpPBlkrB2emq1yFz2K3fs7wGro0DfH3QIdIAq26YqFgIvoOV9wJIbFqukOAD+xNVvae+mPzZnaTZPqgoEXYe4xFQnHJK/TRqlu2F6TzzkfRE8Ak4uRoENuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781096650; c=relaxed/relaxed;
	bh=r4dMD/100adzbPgTxMBB6l472MWU6Q0VLNNG94IBX1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxkpUez12ZaoHxP2G+36YBbsygC0WYbv3p0F9zK4EmutsxfyRsGI0XjDUq+2/QmxBwaI9+/ya0ExsnNPEMwLHcGerc4gsyOBJEkB4D8lRm65IwIyU2hVE+WO592MHsxrLYsk2t9kYB186wFG7/sM61MlcrvYpPUELXcWz1LsE7kWVUTNSNRZhN3NejyU612T5P3Tw48fvty3WAkZ+uh+HP5+OyyFzMPAH0bxNVQRJ5W/hccOfH2zz0xIr+Hn5lEZz7N37J7Ih9sK+8+jG9PMxjqMx8tqkDlTd30RM75qkmGORMJ0ptFcfO7GFlvWRRnWcCPfEMCci//CWDymslM16A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WwLjIBF3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WwLjIBF3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5Zd1B4Fz2yNn
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 23:04:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781096647;
	bh=r4dMD/100adzbPgTxMBB6l472MWU6Q0VLNNG94IBX1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WwLjIBF3WAGB9EPSY9fK0KbP0DJmiznjNWC4PyX5rswzSu4aXDjSvRgRLoHqm2SbO
	 J6hJ5kSFNTQ17zvsM9Po4EqTmStCuPRnbbQbPL3uSkNNJ+i1Je7VOGe8Xm1qHvbeHA
	 1zUST1r9/+/ughClIxibXG5j731EfFCXf6ZkIxNPdWOD2eYiqNtjeBF7FDTMbo56rO
	 9dKH0lWpy1OJZMon8TAkyAeYe7vfYJDiRbVcBFYmuWZItTShfySgM8YGmwlbYeMf4c
	 6ofLl43QtXmKi4cTRuOv9cTyxd57cWzBM0YyiCZD6VwVuln+3VafLFxJjm4TOUkyUf
	 un6ojGE3Gwoog==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7E2DA60921;
	Wed, 10 Jun 2026 21:04:06 +0800 (AWST)
Message-ID: <2d1095b342fe0f4b1b4b99b22bb3af410d9aa60e.camel@codeconstruct.com.au>
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
Date: Wed, 10 Jun 2026 22:34:05 +0930
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

On Tue, 2026-06-02 at 21:24 +0800, Colin Huang via B4 Relay wrote:
> This series refactors the Anacapa BMC devicetree layout to better support
> development-phase hardware revisions (EVT1/EVT2/DVT) while keeping a plat=
form
> entrypoint.
>=20
> Signed-off-by: Colin Huang <u8813345@gmail.com>
> ---
> Changes in v3:
> - Restructure the EVT2 devicetree to inherit from the EVT1 devicetree, ma=
king it incremental rather than standalone.
> - Add the DVT devicetree, inheriting from the EVT2 devicetree.
> - Enable MCTP and FRU support for the NIC.
> - Align PDB fan GPIO numbering.
> - Add an EEPROM device node for the NFC adaptor board.
> - Add an additional EEPROM device node for the SCM.
> - Add shunt resistor values for HSC monitors
> - Link to v2: https://lore.kernel.org/r/20260409-anacapa-devlop-phase-dev=
icetree-v2-0-68f328671653@gmail.com
>=20

So just to check, the changes in patches 5-8 inclusive are applicable
to all of EVT1, EVT2 and DVT (given the way you've structured the
includes)?

> Changes in v2:
> - Fix dtbs_check fail.
> =C2=A0 Validated by following command:
> =C2=A0=C2=A0=C2=A0 make dt_binding_check DT_SCHEMA_FILES=3Darm/aspeed/asp=
eed.yaml
> =C2=A0=C2=A0=C2=A0 make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspee=
d.yaml aspeed/aspeed-bmc-facebook-anacapa.dtb
> =C2=A0=C2=A0=C2=A0 make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspee=
d.yaml aspeed/aspeed-bmc-facebook-anacapa-evt1.dtb
> =C2=A0=C2=A0=C2=A0 make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspee=
d.yaml aspeed/aspeed-bmc-facebook-anacapa-evt2.dtb
> - Link to v1: https://lore.kernel.org/r/20260407-anacapa-devlop-phase-dev=
icetree-v1-0-97b96367cac3@gmail.com
>=20
> ---
> Andy Chung (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: Enable MCTP and=
 FRU for NIC
>=20
> Carl Lee (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: Add eeprom devi=
ce node for NFC adaptor board
>=20
> Colin Huang (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: arm: aspeed: add Anacapa EVT1=
 EVT2 DVT board
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add EVT1 device=
tree and point wrapper to it
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add EVT2 device=
tree inheriting EVT1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add DVT devicet=
ree inheriting EVT2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add additional =
EEPROM node for SCM

If you need to respin this series for some reason, can you please
capitalise the first word of the short description (the bit after the
last ':') for the commits above and the one below?

>=20
> Peter Shen (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: evt2: add shunt=
 resistor values for HSC monitors
>=20
> Rex Fu (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: Align PDB fan G=
PIO numbering
>=20
> =C2=A0.../devicetree/bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts |=C2=A0 178 +++
> =C2=A0.../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts=C2=A0=C2=A0=C2=A0 |=
 1179 ++++++++++++++++++++
> =C2=A0.../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts=C2=A0=C2=A0=C2=A0 |=
=C2=A0 228 ++++
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-anacapa.dts=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1077 +-----------------
> =C2=A05 files changed, 1589 insertions(+), 1076 deletions(-)
> ---
> base-commit: 7ca1caf017d34396397b19fb4de9ecef256f4acc
> change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
>=20
> Best regards,

Andrew

