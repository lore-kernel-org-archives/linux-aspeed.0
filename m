Return-Path: <linux-aspeed+bounces-3785-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8E7109E54B
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 06:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDl10p3mz2yS4;
	Thu, 26 Mar 2026 17:43:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774507436;
	cv=none; b=JJKodPNrRNhLRHt4U7YRWqjxdYtAxrhZrv5UhXo96tFv5cE5mwOJdkoDdoSx8b9U0gWh+ezcGJi46LAidOn+IvdtyYKwXSXR4lGuWFTFN019ZyrdBVsVU7PGxtSaSy/sUIbP+4e4vt48Meeo784pACQKbg+FH54acZHJmpwMaluRLiqqiJxZmdQACO8WJNMnGGqaZ2NJrGCGt2j6xaC4c9r5tDPUSHmFuwrCfodz3WsqcNPDQe2EIn4bVnNQtaYek21qpQ/zzgIhBTpV6jsl6rKpC36lTur0jbcdm9tTx8kJqYY6LwM1gweFGZFj9B7I6EPRaVw2hvidv7p8g/W97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774507436; c=relaxed/relaxed;
	bh=vOXu1h7wNBU0MwKwR9KWxa8v2aRV0Z0aQ49i9AHsRjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pcckbkf0/OfD9z5N76zgHvdIXYEkAix0fBn2rJW8IcduhQ4Xw1Nl9UsFB1ZtYE57AS1ymzGKgqxHdeUwjYgB3BA9rjR4vz77WnSAv1itNZN+re3eSVrhvXn72/T6w9S9+Kh3tLE04DxJvUv47lDotntFw12GdXYjEdLPYehidzwTKd8+cF9yDhm1ekOFgn3Be1bJ3Oi7gTTpUL8oKJ9esZOjK9sH0ZoVORyaqiPsrdgDD5My75ejieY8MIuqytIqusoaEIGyMVD93EUwHUF7pCJsjQLTvpCMdWacxY9ACJg1txh81mkWbmeHvz8yN+Z03nuxw2+7n6MyRfQzoxdYRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Bf9/ogWG; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Bf9/ogWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDl00Wvqz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 17:43:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774507435;
	bh=vOXu1h7wNBU0MwKwR9KWxa8v2aRV0Z0aQ49i9AHsRjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bf9/ogWGTOWi9NWWT9MjUL9Xb1gjCktDc22xDsaivLJwvaS7q8h5C23xkT/LuqKDP
	 zNantjz4ge2Q6oLy8byxuFDXcu/NCMtwp4sAargNiSXUILCWq24o5O1afnUOF2tz9g
	 4Eb2KvSzTpfv6o6z+ft7X7JK6I0Cnx6pElqB+66gZJ4QkVZcG7FsmBQ+El9evKu9vd
	 z9F6EoHHNrxdBxTfVf8XLOwmRtbYtX4fl3ZoTChx7FgNE+TG4I+qC7b8Fur1FBNv9E
	 R42CYgLOWyulFYM1cwKjq2Jw2NLAsxRmtW0/pfR+9z9sLcYRPyRoUJQGqoTyOXt87a
	 PBtgDQ3v6mJVw==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B68C46597C;
	Thu, 26 Mar 2026 14:43:54 +0800 (AWST)
Message-ID: <47adfd499195738bd5539c4e438af5dc1ae75559.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/3] ARM: dts: aspeed: anacapa: update SGPIO mappings
 for DFT integration
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Colin Huang <u8813345@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Colin.Huang2@amd.com, Carl.Lee@amd.com, Peter.Shen@amd.com
Date: Thu, 26 Mar 2026 17:13:54 +1030
In-Reply-To: <20260310-anacapa-dts-sgpio-v3-2-12d9b7f1202e@gmail.com>
References: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
	 <20260310-anacapa-dts-sgpio-v3-2-12d9b7f1202e@gmail.com>
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

On Tue, 2026-03-10 at 17:49 +0800, Colin Huang wrote:
> Update SGPIOM0 GPIO line names and signal mappings to align with the
> latest DFT (Design For Tooling) integration requirements.
>=20
> This change reworks SGPIO input/output assignments, replaces legacy
> or reserved placeholders, and updates signal naming to match the
> definitions provided by the CPLD on 2026-03-03.=C2=A0
>=20

I feel this statement isn't super helpful, but no matter.

> The update improves
> signal clarity and correctness across leakage detection, presence,
> fault, power-good, and debug-related GPIOs.

I prefer you drop this assessment.

>=20
> Signed-off-by: Colin Huang <u8813345@gmail.com>
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-anacapa.dts=C2=A0=C2=A0=C2=A0=C2=
=A0 | 143 ++++++++++++---------
> =C2=A01 file changed, 83 insertions(+), 60 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> index 3e297abc5ba4..85b7e027daef 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -862,89 +862,106 @@ &sgpiom0 {
> =C2=A0	ngpios =3D <128>;
> =C2=A0	bus-frequency =3D <2000000>;
> =C2=A0	gpio-line-names =3D
> -	/*in - out - in - out */
> +	/*in - out */
> =C2=A0	/* A0-A7 line 0-15 */
> -	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
> -	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
> -	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
> -	"", "", "", "",
> +	"L_FNIC_FLT", "FM_CPU0_SYS_RESET_N",
> +	"L_BNIC0_FLT", "CPU0_KBRST_N",
> +	"L_BNIC1_FLT", "FM_CPU0_PROCHOT_trigger_N",
> +	"L_BNIC2_FLT", "FM_CLR_CMOS_R_P0",
> +	"L_BNIC3_FLT", "Force_I3C_SEL",
> +	"L_RTM_SW_FLT", "SYSTEM_Force_Run_AC_Cycle",
> +	"", "",
> +	"", "",
> =C2=A0
> =C2=A0	/* B0-B7 line 16-31 */
> =C2=A0	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
> =C2=A0	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
> =C2=A0	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
> =C2=A0	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
> -	"Channel4_leakage_Manifold2", "",
> -	"Channel5_leakage_EAM1", "",
> -	"Channel6_leakage_CPU_DIMM", "",
> -	"Channel7_leakage_EAM2", "",
> +	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
> +	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
> +	"Channel6_leakage_CPU_DIMM", "CPLD_BUF_R_AGPIO330",
> +	"Channel7_leakage_EAM2", "CPLD_BUF_R_AGPIO331",
> =C2=A0
> =C2=A0	/* C0-C7 line 32-47 */
> -	"RSVD_RMC_GPIO3", "", "LEAK_DETECT_RMC_N", "",
> -	"", "", "", "",
> -	"", "", "", "",
> -	"", "", "", "",
> +	"RSVD_RMC_GPIO3", "RTM_MUX_L",
> +	"LEAK_DETECT_RMC_N", "RTM_MUX_R",
> +	"HDR_P0_NMI_BTN_BUF_R_N", "FPGA_JTAG_SCM_DBREQ_N",
> +	"No_Leak_Sensor_flag", "whdt_sel",
> +	"", "",
> +	"", "",
> +	"", "",
> +	"", "",
> =C2=A0
> =C2=A0	/* D0-D7 line 48-63 */
> -	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
> -	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
> -	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
> -	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
> -	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
> -	"", "", "", "",
> +	"PWRGD_CHAD_CPU0_FPGA", "",
> +	"PWRGD_CHEH_CPU0_FPGA", "",
> +	"PWRGD_CHIL_CPU0_FPGA", "",
> +	"PWRGD_CHMP_CPU0_FPGA", "",
> +	"AMC_BRD_PRSNT_CPLD_L", "",

Can you discuss this patch in the context of my other replies to both
yourself and Kevin?

https://lore.kernel.org/all/d7794f74b26bbc1ee0a70e39c5671acc018f80eb.camel@=
codeconstruct.com.au/

Andrew

