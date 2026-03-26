Return-Path: <linux-aspeed+bounces-3777-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640C5109E553
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 06:10:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhD046ZkSz2xlM;
	Thu, 26 Mar 2026 17:10:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774505412;
	cv=none; b=nU29G9BN3GV1SYewNWb/HxAzUZ53gUibAdp4MFRdkEeptft0zihIo/1VVyhsRuF7W7FTQ08srWk1bOD0sIQTPM+Fg46CBg8w+P3WNhC6b4l4yumNagiRb2qEBCcB3m8it6JeDvSDuLuk+MkH+d9stB0s0zNM1OjhU6gm5nEywxAJW5WH/Yaix00TcdwCgYsiR0c16J7woPltzaGVaxjpy1CQYpoRXQaIeSF5m4nFtkwb+x18SeijX4ygiyLPRt9LfmHn+7AcuZpKrSYTxKjw0wYHcbh7OrGUprXt3yhtjqzdcVUtQthK+m6qkU2GIOpzxM6muQWOd6jJIapvgOko/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774505412; c=relaxed/relaxed;
	bh=hidLBtwhQbxPBXbheN85pSsa8RQxYeW+MLrk6uzD3ac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C028EvTRn0NI9WRulXDZ+eH4pkHiOmaYBy+p94jWzjAuoc4o42LgXZ8MFhYii2oQfjmAT96W+yOvvjap3rMHFwE4SWZADFVaRIEJ3meUBVh98v9Bfcdt73oHWVEJE70I0paDMMEPSEZ/Tui27UTCVzA14BcoFHp5K30PU5GFmEOVHsUnKHoQvn85EcTEkyKG7AM9DmhgHA5O96XSsxGshWXnBPpk41CNLLZCeOO1UVDnwSMj0Wx3PAvRFPaCFcAWUHjbpDEKaLk7JBtVfkGVDmURI+a7itKyLIRDjyprQEqK0Hg4vzE+wPdIlpSqKbTKISIi8GoO0G3dW53VAj6csg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KMhiSzgs; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KMhiSzgs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhD04145jz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 17:10:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774505411;
	bh=hidLBtwhQbxPBXbheN85pSsa8RQxYeW+MLrk6uzD3ac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KMhiSzgs0FiJF1ZY/gHkQ+gt0zCunXJNaCStpNJfIiNdsSrkcKNb5QW4c5Grx5QBE
	 ENlC2WhRG/AQG+nVfFt3lXtpRvLKPI2NNgQ9qbL7UR3SevefGE6eu+AJjhD3bpI9W5
	 NdlWFj4g10N/XCODybZzWndp94Kxey7+q8n6iayvQknF3uu7P7Hjm8WxrydLnQOWuE
	 9qrSj5odCfF9zbpupYHRX27hyo26d3auWuZsCYSgmwTzB+6twIozI8Lilaw0jUie/B
	 O8QIOOAqxm2R99ITRmwjfSZaBV37z6Vl0/kSbm27JvCsd+Gkm6Pc+aJAldaXi+ik7J
	 VM5DHsKt4rviQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D19B36597C;
	Thu, 26 Mar 2026 14:10:10 +0800 (AWST)
Message-ID: <e24ec25ff7d731cf6ca094028b1336dacd01ac9c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 3/8] ARM: dts: aspeed: yosemite5: Add new SGPIO line
 names and rename signal
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org, Amithash
 Prasasd <amithash@meta.com>, Kevin Tung	 <Kevin.Tung@quantatw.com>, Ken
 Chen <Ken.Chen@quantatw.com>, Leo Yang	 <Leo-Yang@quantatw.com>, Jackson
 Liu <Jackson.Liu@quantatw.com>, Daniel Hsu	 <Daniel-Hsu@quantatw.com>
Date: Thu, 26 Mar 2026 16:40:10 +1030
In-Reply-To: <CABh9gBe2BcgnONwx=cmcOAsT15HgVGjxSChgFMvckTAW_8JfMQ@mail.gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
	 <20260223-yv5_revise_dts-v5-3-fc913e902488@gmail.com>
	 <391b9b912492c07fd1fd7a737b7f49382d361fe2.camel@codeconstruct.com.au>
	 <CABh9gBe2BcgnONwx=cmcOAsT15HgVGjxSChgFMvckTAW_8JfMQ@mail.gmail.com>
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

Hi Kevin,

On Mon, 2026-03-09 at 11:34 -0700, Kevin Tung wrote:
> > Broadly, it feels a lot like you're revising platform designs, then
> > trying to make the one devicetree fit the current design, and are not
> > explicitly communicating that this is what you're doing.
> >=20
> > If that _is_ what you're doing, then we can come up with much better
> > schemes to handle it that aren't a constant stream of compatibility
> > breaks.
> >=20
> > I need you to engage with this concern.
> >=20
> Thanks for your feedback. I realize there may be a lack of knowledge
> on my side regarding the best practices here.
> Could you kindly guide me on how we might implement a better approach
> that avoids a constant stream of compatibility breaks?
> I=E2=80=99d like to ensure we handle this correctly and align with the
> expected workflow.

Sure, see the reply I just sent here:

https://lore.kernel.org/all/d7794f74b26bbc1ee0a70e39c5671acc018f80eb.camel@=
codeconstruct.com.au/

>=20
> > From inspection, I only find patches 1, 4 and 7 of this series to be
> > something I'd consider applying without further discussion.
> >=20
> Got it. Should I split patches 1, 4, and 7 into a separate series?
> This would keep the current series shorter by excluding items that
> don=E2=80=99t require further discussion.
>=20

I am okay with that, so long as it makes sense in the context of the
discussion linked above.

Andrew

