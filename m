Return-Path: <linux-aspeed+bounces-3331-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E944D3CC8C
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 01:03:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds4V66lmXz2xqj;
	Thu, 15 Jan 2026 12:03:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768438990;
	cv=none; b=ZTJ5nv51Fuy7j4SkD3q7Z8frcjwxH0YKkL91NbZIZnaDF6u3hY+1eUB86CblgrKN+/Z/mC/KXLLav6aC+1vxx5Fo/jzHJboYPIwlxERyFCvtI389yME7nHH9huOAoDPpat3KdVHsKdrZrokL7jMqmxNxxNG739OjeOyhr3eqwJAgeoYfJhKgCo6Q2/6+l7SR7nCEJ4EhOXwUERVTa2WHkG4TPrvD7EhoUrhRFvLijFC/5S2Llxaom8HUaJQcR0NMgK9PJ/FQrzcJ7IwzEgBc8cxBvLK6DAGnTD57CnhcXuww0N4xY37/LG8Wqq+R5g72zLUnWn4OjWONFNiuIzS+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768438990; c=relaxed/relaxed;
	bh=vNKDUiHsavl59v4nItB4xiNjLlP9UEeSBtTXPjQXdBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dx2kPH4+FSdQEpwWZYTsmgx+JL5+PwcW8wRXYwlNtt3EK0rzwkqz9MLqUoRjBDYhLMKsLfeeOG0+uc64duis7dpqyu3AjB34UYUFlJsOma0xcIyBp7dnRsykG4ZCmdO6rq9l6K67ZfNaa2gAY5P0RNeDOra6OlTLtHHyP5CTvoIFGYHe6mJHwtzb8ixEa1Oh3Xrk2NXswfgZnhsxzguZDvubb77s2nr9h9TFgsGdvPjLZzKAabU7638/nCwVHA1ajd4PSlqOseghCEfi+cjPZ9EDdyzLt6Q638eGgKU1bOkeuqJDxb8Q0o+yZcvwxnUZ2UhC/X1Rax+jinFDIH1zBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=cxdHa5ze; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=cxdHa5ze;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds4V54Mt2z2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 12:03:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768438987;
	bh=vNKDUiHsavl59v4nItB4xiNjLlP9UEeSBtTXPjQXdBc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cxdHa5zeFDY6ZQnhIBWDefU1M3cQbxocCQ7lpdhq5qtapmWol2FGMOJxCqBflrrfm
	 2GDKsyZcArL5RqSJOVYKqE3alXTxuLN+Jt+Vko31snrBEI+ygi/+XwGXuASYwOlthc
	 JZ6QqdbH+Ay/AZWpWqBG6dEDfRyUaZN3I28MQD/zF00dacVfua4mY2VrKVtm96hTyO
	 Jfyvfbnt4r9nbhM8diehDeLkz93y56kcabXAmO/9GsZgKW0Kh98+sn9fOTVGaU2Eoz
	 Yi0/TWf4YQNG3KCTb1beASIYgiKRGtUDRsTYeCb7O2i3q9QMmGa1B72V3ojdIf77LO
	 VTDiLha813c9g==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BEDD46472A;
	Thu, 15 Jan 2026 09:03:05 +0800 (AWST)
Message-ID: <0e611132794491eecbcd3426222b6dca09a35b84.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asus IPMI card
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 15 Jan 2026 11:33:04 +1030
In-Reply-To: <CAJ13v3QYWRfyivrbP=+hreHuMkYWGPkngW3kJyq6xNVL6YdpgQ@mail.gmail.com>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
	 <20260111201040.162880-2-anirudhsriniv@gmail.com>
	 <45bdf2a6c0d33dd6ce0fd3cc279ef6edc509a540.camel@codeconstruct.com.au>
	 <20260112-whimsical-annoying-fulmar-25e4d9@quoll>
	 <CAJ13v3RKydFK+sP_Cm-HnQjsOJSDyX_dsGs_Yy564V=Wc7tQFw@mail.gmail.com>
	 <e97b7a193f8bbfca9ec00037808ad80a5baf9f00.camel@codeconstruct.com.au>
	 <CAJ13v3QYWRfyivrbP=+hreHuMkYWGPkngW3kJyq6xNVL6YdpgQ@mail.gmail.com>
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

On Tue, 2026-01-13 at 16:28 -0600, Anirudh Srinivasan wrote:
> Hi Andrew
>=20
> On Mon, Jan 12, 2026 at 6:57=E2=80=AFPM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > Perhaps we could incorporate either of those?
> >=20
> > =C2=A0* asus,e21524-ipmi-expansion-card
> > =C2=A0* asus,ipmi-expansion-card-r1-04
> >=20
> > However, they're not without some risk:
> >=20
> > =C2=A0=C2=A0 1. It's hard to tell whether E21524 is properly representa=
tive
> > =C2=A0=C2=A0 2. R1.04 may also problematic as an AST2700-based card wil=
l likely
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restart the numbering and risk a collisi=
on
> >=20
> > Otherwise, I guess there's:
> >=20
> > =C2=A0* asus,ipmi-expansion-card-ast2600
> >=20
>=20
> There seem to be multiple revisions of this card. The photos have the
> revision number printed on the board and the manuals have the E21XXX
> number on them.
> R1.01 - E21362 photo [1] manual[2]
> R1.04 - E21524 photo [3] manual[4]
>=20
> Mine is the latter. There seem to be some differences in the layout of
> the different headers on the board, but the same set of headers are on
> both boards. There is only one fw image on Asus's site, so I guess
> they're the same from a sw point of view.

Ah, interesting. So the R1.01 card also has an 'E' number silkscreened
on it - 'E248779', though this is different to E21362 from the manual.
E248779 seems to alias to a lot of other ASUS things. Given the
variance and aliasing it's probably a good idea to avoid them.

>=20
> I've linked a screenshot [5] from the webui on the stock fw and it
> says that the firmware model is "KOMMANDO". Asus also seems to name
> the fw update file for this board KODO1140.ima (KODO is short for
> KOMMANDO?, 1140 is the version number).

> I looked at other Asus Motherboard onboard BMC fw updates and they
> seem to be named <Mobo Model><version>.ima. Example board "Pro WS
> W680M" [6], fw update name W680M1121.ima, another example board "Pro
> WS W790E" [7], fw update name W7901167.ima
>=20
> "asus,kommando-ipmi-expansion-card" is a bit long, so maybe we should
> go with "asus,kodo-ipmi-expansion-card". SEO for either of the 2 terms
> is not very good, but that's not what we're looking for here are we?

So downloading the releases and poking around a bit, there's this:

   > for f in */*.ima; echo $f; dd if=3D$f bs=3D$(math 0x100) count=3D1 ski=
p=3D$(math 0x3ff00) 2>/dev/null | strings | sed 's/^/\t/'; echo; end
   IPMI_EXPANSION_CARD-1.1.26/KODO1126.ima
   	$MODULE$
   	ast2600e
   	UFW_VERSION=3D1.01.26
   	FW_DATE=3DJan 9 2023
   	FW_BUILDTIME=3D10:23:36 UTC
   	FW_DESC=3DAST2600EVB SPX-13 TB2
   	FW_PRODUCTID=3D1
   	FW_RELEASEID=3DRR9
   	FW_CODEBASEVERSION=3D5.X
  =20
   IPMI_EXPANSION_CARD-1.1.33/KODO1133.ima
   	$MODULE$
   	ast2600e
   	UFW_VERSION=3D1.01.33
   	FW_DATE=3DJul 17 2023
   	FW_BUILDTIME=3D09:25:13 UTC
   	FW_DESC=3DAST2600EVB SPX-13 TB2
   	FW_PRODUCTID=3D1
   	FW_RELEASEID=3DRR9
   	FW_CODEBASEVERSION=3D5.X
  =20
   IPMI_EXPANSION_CARD-1.1.34/KODO1134.ima
   	$MODULE$
   	ast2600e
   	UFW_VERSION=3D1.01.34
   	FW_DATE=3DFeb 27 2024
   	FW_BUILDTIME=3D07:45:26 UTC
   	FW_DESC=3DAST2600EVB SPX-13 TB2
   	FW_PRODUCTID=3D1
   	FW_RELEASEID=3DRR9
   	FW_CODEBASEVERSION=3D5.X
  =20
   IPMI_EXPANSION_CARD-1.1.35/KODO1135.ima
   	$MODULE$
   	ast2600e
   	UFW_VERSION=3D1.01.35
   	FW_DATE=3DAug 20 2024
   	FW_BUILDTIME=3D08:32:35 UTC
   	FW_DESC=3DAST2600EVB SPX-13 TB2
   	FW_PRODUCTID=3D1
   	FW_RELEASEID=3DRR9
   	FW_CODEBASEVERSION=3D5.X
  =20
   IPMI_EXPANSION_CARD-1.1.40/KODO1140.ima
   	$MODULE$
   	Oast2600e
   	UFW_VERSION=3D1.01.40
   	FW_DATE=3DApr 15 2025
   	FW_BUILDTIME=3D09:52:26 UTC
   	FW_DESC=3DAST2600EVB KOMMANDO SPX-13 TB2
   	FW_PRODUCTID=3D1
   	FW_RELEASEID=3DRR9
   	FW_CODEBASEVERSION=3D5.X

KODO is pretty consistent in the firmware update file name. KOMMANDO as
the product identifier also seems reasonable, even if it only appears
in FW_DESC in the latest release. KODO -> KOMMANDO seems reasonable.

A brief bit of binwalking suggests it's an AMI MegaRAC implementation,
and so I expect 'SPX-13' in FW_DESC refers to MegaRAC SP-X[1]. The
significance of 'TB2' isn't yet unclear to me.

I'm not super concerned about the length of "asus,kommando-ipmi-
expansion-card" - I'd prefer it over incorporating the 'kodo'
contraction.

I guess it's still unclear whether 'kommando' is a (future) line of
products or refers to the specific AST2600-based design. Perhaps we
could solve a few problems with 'asus,kommando-ast2600' and including
the phrase 'IPMI expansion card' in the binding description for
something searchable.

Andrew

[1]: https://9443417.fs1.hubspotusercontent-na1.net/hubfs/9443417/Data_Shee=
ts/Firmware_Solutions/MegaRAC_SP-X_Data_Sheet_PUB.pdf

