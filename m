Return-Path: <linux-aspeed+bounces-4051-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC22CD343F
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 06:48:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJpKG0Yggz3c5M;
	Mon, 18 May 2026 16:48:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779086881;
	cv=none; b=jFHhfXRqGhedyt4IAMT/JJT8vgapBArDyD9N8/7PkdVXiwS7Uz6xrUNQRz+MVo5WtvUyAExNgrBjeG+wD5NreEG8hQFOnDHr3iVM4M/8LVVXicJULWcstgOrkLmi6XMWNJcFSKtw+hXQww1ZhmxD9MNkhWdPZvZat+TJiDF41vdN6ponrl/6CvczSuQ2+BA4ukn6coE5yYlN1oytIO+a5QNetvMZiK1yIjzUEnWRXa01WQdjX87XVhtsxo6jbqWauPPRoK7bchIv9rmgaAkWRholLg0NS5JCZVC2OVn3zFIOq3zA0LSs1nYZgTaw84PRCR5m1EzfzPYPuzcbhePEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779086881; c=relaxed/relaxed;
	bh=yCIIJPedrSN9Nbfy8rMYwb7u5VqcNWKHuQcBf8AmRZs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXoWahqQB2RUbG6CpOkE/+t5zhqCl/VxhxSpznlBBTKWUQFc/CwD3qBL+3IPDd9n71cOnVY5mAoE+rFJC4gLDJAyAjRTZXyUd1EmmbwXHrd8X4HgmeA5SMgdkvOVmw7Cm3N6+MpjZf4kpx5nEtgorLUR9mzFk84p2JbJtSM/JBXDBQuHmriH71C/Ec0wJ1V3BCFrrOxBht/pE2v01owMBNHjM8Zak6sDZrtAm62TfkCksrMOzfdjvhBFtI/0qYQ08HYKBR8/irByUApL8UY2xxQg3BJnFmlreLP6/WbQwKxoGwgXgzd9FZnqEwGOmO61TdEPgCo0feyE/L0Nu5LTcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Rhb6Eg43; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Rhb6Eg43;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJpKF2swfz3brc
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 16:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779086880;
	bh=yCIIJPedrSN9Nbfy8rMYwb7u5VqcNWKHuQcBf8AmRZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rhb6Eg43fawS7KulytVw/afj3ttEg0nj3SdwaLqNePcoGJiVmQr7INEVY36wTkGpf
	 7gRk0gNebpLCaOTnAJiPe+S0NaFc7mQyCnDuHM+bly+eEScA2MdswmAL6H1NU0X67b
	 ffimn4S+Q0l0fbYRmip4G3GnylimDSmBH0o27rE5YGsEvnb/NbVVTbW3B1D09023S+
	 qslXNV4KhzfDQF5kVJDLAnOHmjTCd3rl5hVUm2a6/tvU3KE5oz0tSILFBbpMIxCYPV
	 ick4TLd4wrTDm8aYIM9jQrFzneghHldyF11c/Q2eTPrsW7IlBKvT3P5mlJeV+1H0iX
	 4RPpGvf0sFUHw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 547616025D;
	Mon, 18 May 2026 14:48:00 +0800 (AWST)
Message-ID: <bae3a186da639118d88ad2632c5edf8963946dc1.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: anacapa: name EDSFF and thermtrip
 SGPIO lines
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rex.Fu@amd.com, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 16:17:59 +0930
In-Reply-To: <20260430-anacapa-sgpio-edsff-thermtrip-v1-1-2fd5e72435d0@amd.com>
References: 
	<20260430-anacapa-sgpio-edsff-thermtrip-v1-1-2fd5e72435d0@amd.com>
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

Hello Rex,

On Thu, 2026-04-30 at 13:44 +0800, Rex Fu via B4 Relay wrote:
> From: Rex Fu <Rex.Fu@amd.com>
>=20
> Name the Anacapa SGPIO lines used for EDSFF power-good and thermtrip
> assertion signals.
>=20
> The affected lines replace legacy
>=20

Which are legacy?

>  or unused=C2=A0
>=20

Which are unused?

> CPU-related names with the
> platform signal names used by userspace monitoring.

This is the kind of change that has the potential to break old
userspace. Why is it appropriate? I'd like a more precise discussion in
the commit message.

Was there some other underlying change (e.g. a new revision of the
platform design)?

Andrew

>=20
> Signed-off-by: Rex Fu <Rex.Fu@amd.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 10 +++++=
-----
> =C2=A01 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> index 2cb7bd128d24..fe960bb7bc27 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -912,7 +912,7 @@ &sgpiom0 {
> =C2=A0	"PWRGD_PVDDIO_P0", "",
> =C2=A0	"PWRGD_PVDDIO_MEM_S3_P0", "",
> =C2=A0	"PWRGD_CHMP_CPU0_FPGA", "",
> -	"PWRGD_CHIL_CPU0_FPGA", "",
> +	"HPM_EDSFF_PG", "",
> =C2=A0	"PWRGD_CHEH_CPU0_FPGA", "",
> =C2=A0	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
> =C2=A0	"", "",
> @@ -957,8 +957,8 @@ &sgpiom0 {
> =C2=A0	"PDB_ALERT_R_N", "",
> =C2=A0
> =C2=A0	/* L0-L7 line 176-191 */
> -	"CPU0_SP7R1", "", "CPU0_SP7R2", "",
> -	"CPU0_SP7R3", "", "CPU0_SP7R4", "",
> +	"L_EDSFF2_PG", "", "L_EDSFF3_PG", "",
> +	"R_EDSFF2_PG", "", "R_EDSFF3_PG", "",
> =C2=A0	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
> =C2=A0	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
> =C2=A0
> @@ -984,8 +984,8 @@ &sgpiom0 {
> =C2=A0	"HPM_PWR_FAIL", "Port80_b0",
> =C2=A0	"FM_DIMM_IP_FAIL", "Port80_b1",
> =C2=A0	"FM_DIMM_AH_FAIL", "Port80_b2",
> -	"HPM_AMC_THERMTRIP_R_L", "Port80_b3",
> -	"FM_CPU0_THERMTRIP_N", "Port80_b4",
> +	"AMC_THERMTRIP_ASSERT", "Port80_b3",
> +	"CPU_THERMTRIP_ASSERT", "Port80_b4",
> =C2=A0	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
> =C2=A0	"CPLD_SGPIO_RDY", "Port80_b6",
> =C2=A0	"", "Port80_b7",
>=20
> ---
> base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
> change-id: 20260430-anacapa-sgpio-edsff-thermtrip-acb228bf61be
>=20
> Best regards,
> --=C2=A0=20
> Rex Fu <Rex.Fu@amd.com>
>=20

