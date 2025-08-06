Return-Path: <linux-aspeed+bounces-1907-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34582C87FD1
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 01:15:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxXR35x68z30WY;
	Wed,  6 Aug 2025 11:15:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754442927;
	cv=none; b=YfCZUuEBjxujXN2zAR9YWfpYIl9grlhtgsfS7G1WAumS2PIIVgOwzJBPpFTGbyhlb9UaPwf/rIoUL7J2vsogXgGKTwpCTePWcFUIqghTAW+WSp24Nl88s463zdMv/BH4T+uzd//WonxBIx20OEHd475bRxv0Y8nazbPGV5m+DVBMt9p0fT0JfN7/Ev49a/6q5UgtA3H8dp1UjIwgPQ6MVoHrFsG10LD7/g6xtv7twDOX7TesrF3ICIwlfyJ9onDLUvVfO/RC8PuSquaoz/UQZ8VtIB+CU0tcZE4ZM54laAq9UfyUMcMkhqZD32uw3p5fvFLkqOY5cwSRyRq9iKXidg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754442927; c=relaxed/relaxed;
	bh=q16sqgrcDh4TW6b6QGnthsd0Rh9/8L6NGJ8pTp9TjsQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=feSF/hBF0I4NIuT85eGRquUEqAJn2aiU/TTDUf2vMYCHz+EUbwsowfjT0t4UtTOmY/PRh6Y/hV34yfhNPF1ofAxsyta8SCPdZNWUAyiI56oTDz2/vb1E+zyKFaNooSAIBkh79dAoWwEMlZK9DsnpcfauIa/ADEoRgBTdBm2XGJCOkrRFf8f5KjV8twO64bWreFsYQd/yBojwNUEgkCJDO01Y1pvP0Fv7XDTFitnNJKXoTGiLTxYrU6D9mXNijQazsD+AH6oGOSoGqfE1El36B5JU0yUVQ9mSmRC/BsSvYWhddib0kIIN7O3fhD185GWs0phGdnTZ0CxTYSCdeH+JsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Phvbf0Z9; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Phvbf0Z9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxXR323s8z2xck
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 11:15:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754442926;
	bh=q16sqgrcDh4TW6b6QGnthsd0Rh9/8L6NGJ8pTp9TjsQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Phvbf0Z9KeOg7rHlR0UiPwm32b3qtbFS8lDlSG/PwVIw4TIwlThELZnZVwv+O6ILz
	 DrGVUl+Oo9PkULcyyHBgHV/Wxa6mm2kAnT4DFA4XmRKSLhNZjY9jueaPe0k+BRYCFZ
	 xzO6UTEgpsVjY7r0A47KjJ/sF8+1S0OU1pIT9xO4qg43tHsc0yjekRvw0KgrCOu8gP
	 tm3yN/TCZVdQisfqQjPwKvySpr15wYSZjXPpnzlpd6xRUzwE5abW2vJH/h8eNR3Y4c
	 NK5rjs88ErIgU/GaeIrxy4ybhMXj4ZeJLqYsAFcKFNriwC1LrBuANg3qP+ldg4M9xm
	 Zqo4VangpeT/w==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 544F06BFF3;
	Wed,  6 Aug 2025 09:15:26 +0800 (AWST)
Message-ID: <182db4f2848dc7b8c110d45bb606e6219983c237.camel@codeconstruct.com.au>
Subject: Re: [PATCH] drivers/soc/aspeed: Add AST27XX SoC ID support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 10:45:25 +0930
In-Reply-To: <20250805063957.1452653-1-ryan_chen@aspeedtech.com>
References: <20250805063957.1452653-1-ryan_chen@aspeedtech.com>
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

Hi Ryan,

Regarding the patch subject, can you please follow the patterns
established by other commits under drivers/soc ?

Separately, can we concentrate efforts on trying to get the platform
definition bits upstream for the AST2700? Arnd's recent newsoc PR adds
several new SoCs (as the tag name suggests), which is a helpful
reference:

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=3Dsoc-ne=
wsoc-6.17

Cheers,

Andrew

On Tue, 2025-08-05 at 14:39 +0800, Ryan Chen wrote:
> Extend the ASPEED SoC info driver to support AST27XX silicon IDs.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> =C2=A0drivers/soc/aspeed/aspeed-socinfo.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/asp=
eed-socinfo.c
> index 3f759121dc00..67e9ac3d08ec 100644
> --- a/drivers/soc/aspeed/aspeed-socinfo.c
> +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> @@ -27,6 +27,10 @@ static struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2620", 0x05010203 }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2605", 0x05030103 }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2625", 0x05030403 }=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* AST2700 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2750", 0x06000003 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2700", 0x06000103 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "AST2720", 0x06000203 },
> =C2=A0};
> =C2=A0
> =C2=A0static const char *siliconid_to_name(u32 siliconid)


