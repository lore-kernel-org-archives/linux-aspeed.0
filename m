Return-Path: <linux-aspeed+bounces-4531-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C3AC44539
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 12:07:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4tL250bNz2xLd;
	Wed, 22 Jul 2026 22:07:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784722058;
	cv=none; b=FY2foMDbY01YFqS33GHP7KfQ35uZSB9MOUBYzvH9scXpfkBhAah6oGKwaEEmDijsyxoE0Nqel+pVIPv8Ndyy7ZUlu+1qwlFm5aj7WFE7tGEsEf/MPAEXN/TjMnq2EvikEyAlhanTDLswRdPVaBO19Fyxb8ZdGznbwVWqBAH/uae8enOOLkQPIHrt9++w9sParXVSlldNPjN0OtQh59c05G7KlFxE5OLAE/Ai5QAcV5B/XIHTJtLyB27kFYObdouzCSShkAaAugrcoieF10Cic6zNN2ABFU/lfL/rBHhvKPO8Rrhrsn7MrkOfl5OTGAaGZdgZqjTfyPdcLs7ghwufDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784722058; c=relaxed/relaxed;
	bh=qEo3cAwztk9OWvKbynD/A3a+NoqgXRz66n8QzFJBxdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FftHYgL1THHG5rhnioXOWUfNUKL0/+ID4ovFKzMHJ9jM6SQ9Fncy71m5WbrJhJ5b4Nl2hpx7MTS+f9Aq7eXfoRiwgQ5buWz+gsD5wXSWnrwTOr5dnTMMMu0GmmYDvegqoKrME/QdL8CC1IJiTx8IX2seyu2XyemXEZkyE0SAhKwj6NNneZgUsxq5FCKEXp2Z7qnlu23qsyWvjEtpo6OcI7fz1CLlHSledgqu7DC1HivgA9DBy6hDpxwxIZ19UrrNidtm3iF1X8B+bx4Zue8HjviRhtoKUrAMOMPwkZdymnVJdmbLoce7hLANpTluBBrXymL0WCFO01ubd4ULo9am1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=D/OhMC7s; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=D/OhMC7s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4tL224pzz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 22:07:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784722057;
	bh=qEo3cAwztk9OWvKbynD/A3a+NoqgXRz66n8QzFJBxdU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D/OhMC7s+fcNqNNul2lHX/zlar+PF4e+66S0kXD/J7seotqOU2O0XHqCZUtC99A1f
	 3geW6mwhMP3OTAYMc/oBKgZAxFYejK1q9bv3LQx8V7PMqu0XXG5DOBKxqEPCk30sDE
	 Pj47ToMpmrDMwPtYI6FgYA9zESC4cKw8mUw/Ynpchw/ubEO6I2mREqTtQmMFUBt/O+
	 2WSHAbXhk6pIBoeXleasBzpgT0BhrI2xxsb/c5oHNEtvn0687Ii7Y/bfTYN3mOpnVC
	 8E7UPmM1qAJ71Wg99WwJ2DEDHCuEG8e943Ss3uKUSnOpHJtWQyJlhDNqWQZOcnJ51k
	 HfluMi642WSQw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4BDFD662E1;
	Wed, 22 Jul 2026 20:07:37 +0800 (AWST)
Message-ID: <a6170c549dd8fe3851854de44c2bd43dd0ec1f95.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: sanmiguel: fix PDB HSC shunt
 resistor
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Mike Hsieh <mike.quanta.115@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, Mik Lin
	 <mik.lin@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>
Date: Wed, 22 Jul 2026 21:37:37 +0930
In-Reply-To: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-1-cccf959c9b78@gmail.com>
References: 
	<20260618-sanmiguel-dts-config-hsc-lm5066i-v1-0-cccf959c9b78@gmail.com>
	 <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-1-cccf959c9b78@gmail.com>
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

On Thu, 2026-06-18 at 15:41 +0800, Mike Hsieh wrote:
> Correct the shunt-resistor-micro-ohms values for the four TI LM5066i
> hot-swap controllers on the PDB. This ensures accurate current and
> power sensor readings from the hardware monitors.
>=20
> Signed-off-by: Mike Hsieh <mike.quanta.115@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 8 ++++=
----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)

I've applied this one.

Thanks,

Andrew

