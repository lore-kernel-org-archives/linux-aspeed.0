Return-Path: <linux-aspeed+bounces-4544-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B791C4452B
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 04:13:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5HmQ6qf4z2yVZ;
	Thu, 23 Jul 2026 14:13:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784780006;
	cv=none; b=CPMejjM9o+oHQGPInLJ3SQJnPh+cBVdtDnRtuZlnfTi9upUFopPHs2xD27n4LFXX4Y2ZoIDMZvjM5Xwo4wdNdYsDKtVljW1uw6wCjNxAJ+69sEjpPdUE12qSZziwHEmGGNiyXfrsDZo6NfgbXCqZr9IbR4kBOKLmoUiLiJE8C1YMUSt37xvRjjrcfg9TkZQmgN4+aAzBkSFO37nUADYKpsMgRc6IaTtGCjTtivfqGBSsgshUD0BxJPwJkOlCW3wVJ/h8ejb6CMnstZ9xldYVzSofkxEaCj0onMnMCxGopcmhf3WNh7i9FrP41ZMi9APPASn0GN5Gf9ag3ZLkC5XYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784780006; c=relaxed/relaxed;
	bh=1CNvGj7dz891iLVwt7dBaj1OEv/TlmZnFAcX0NW2E2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jt4VUJDPpXYHIgiNsjCS3D20vlDPMzvEYzyA2+/W9MbqMLIHCVKw3X72+O4OKZZDSm9Kax5N+vnyIfWmi5Vgu4gYhYiU7/d7SwQEAMUOZLUMNFfmnQKiy3KjwtEcXuIda8zhGRrr9hWh5sqsXy7+AFz8JufgHG4zBPjXw4OPBmKozYGhJtMj8RnZX2tjO4vOm/j7QvlzIqY31/UrYHz4JDaeV5iYarYShMh/2fnJEyrbTJoO4AtGSzDf8715KmsYyp0h1buTZc3qNTnpES+MLFW7ipOybCEjhawkGzw4+j3/uJLy0eepJygjhzEekpbkeUnvgSw/rfpIhRXPijjHnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E+XH9OXP; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E+XH9OXP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5HmP6L06z2xJT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 14:13:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784780003;
	bh=1CNvGj7dz891iLVwt7dBaj1OEv/TlmZnFAcX0NW2E2s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E+XH9OXP/w2dxS8B/KIVBxE36CT1gB6cvXTlb9xoXFDorIlXxfB5A9CiOg2E8TY2/
	 0vJaoMwSwVefDlf2t/b23LkdA5420QSR8v3AnhdxI/6djGdOaySel88Z3w/9cTPwce
	 WN3GciiG88uDC0NM9fHdFdnh89x+UVxuYeCiJq2qOFLtpvJ8+NnCoaMFYveReLOvdd
	 loe383NY4q+pIHEDmqpAKq03RrP+AaBatzLpFV8b8lzcb59Ph4bcdkxSmWh3PrYAx+
	 Viq8vzMA/lANaFmLa03sjl7hqCBNZN7YgoG2jUQRuXsgEoziPdZgSGJiXC3hEIbTKr
	 AKErYsmUxS/HQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 47054662E1;
	Thu, 23 Jul 2026 12:13:22 +0800 (AWST)
Message-ID: <afa321db51d5e6cc8e0c15badc7204faa0925251.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed-g6: add pcie-kcs4
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>, 
	joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corey@minyard.net, devicetree@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net, linux-aspeed@lists.ozlabs.org,
 	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 13:43:21 +0930
In-Reply-To: <0b97a66762efc05c9073c14112cc489624871947.1784732161.git.gregoire.layet@9elements.com>
References: <cover.1784732161.git.gregoire.layet@9elements.com>
	 <0b97a66762efc05c9073c14112cc489624871947.1784732161.git.gregoire.layet@9elements.com>
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

On Wed, 2026-07-22 at 15:11 +0000, Gr=C3=A9goire Layet wrote:
> Add pcie_kcs4 node to the LPC bus in the ast2600 g6 common dtsi.
>=20
> The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
> interface on channel 4. This is a fully KCS-compatible interface
> that is exposed over PCIe.
>=20
> This can be used by the host for IPMI when the PCIe BMC Device is
> activated.
>=20
> While the datasheet provides interrupt numbers for KCS channels 1, 2,
> 3 and 4 over PCI, not all 4 are described in the "PCIe to LPC Controller"
> section. Since only the KCS channel 4 is described, only this channel is
> added.
>=20
> The pcie_kcs4 uses existing "aspeed,ast2600-kcs-bmc" compatible as it's a
> standard KCS interface.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/=
aspeed/aspeed-g6.dtsi
> index 56bb3b0444f7..a93fa4cf5d8f 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -617,6 +617,13 @@ kcs4: kcs@114 {
> =C2=A0					status =3D "disabled";
> =C2=A0				};
> =C2=A0
> +				pcie_kcs4: kcs@914 {

Nodes need to be ordered by ascending address:

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-=
nodes

Note that we now have scripts/dtc/dt-check-style which can help catch
such issues.

Andrew

