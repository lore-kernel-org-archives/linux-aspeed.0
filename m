Return-Path: <linux-aspeed+bounces-1146-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52279C36010
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Apr 2025 00:52:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRTx45C5Tz2yb9;
	Tue,  1 Apr 2025 11:52:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743468744;
	cv=none; b=gP+IySlLZaSwPBfKi0pklMsF0BPrLAMzlFnMQw6BKPHLwzUBYfEMFSMsmrLL/UZkIgljRtTgqvkrPDNCOzFDmbHUScMTfFiiYtsUEeD1CYFbIxcNICPwd1nLALs4yi2HlL71wt2Zhz/hkMtvY9HT8h3Ii8AFoRtGKcBCHVqm7a6xtaWIWSlOPFjayNXao65OA3q5kw9q7si4A+rHS7fcINrK8vToyK/Sm8OJSZDuXU2TRqxRtsT8WoIG9pbTY7U1Z6RgaXlY20PgoPIpFRJ8lh3MEFmJlKRYJM+DzDpf7eYen7VOnvmAjITiX2uqLP5JVBQgKxPnGZeBlk20v6hmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743468744; c=relaxed/relaxed;
	bh=OPokjJS6bZ7xjIKgUxLbF7tf4xmoAmvSOaiF5AsgPL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOittHyFR9shSQBGsscSQU0gDanLa65HeZS+hK5dCjy35xfRTt6gNUaYyik+VYtcjl1+x38d1UJnVPDp1oETmtp6lAGagcGFDjgWW1KcvUoTyzWQf8wOz1WY3oBIKIEVMtDO/SR4HUOsVBtnBNxCpHU4BDWpMjcd6PbNVlnhyLu5gX0ZxqXKXviRoCTqvqFdikC6KAYQ1PRs0Zm2RwYw/L5Q+g06aEFU3XSEeJVoT+mkLbHKHK+wn0FJrAo161YVoECYhLf0QtoRPsiYXjKbCzEVibJLjo9om7mcm5dlZsUsRFJIGgF8JUtulUj+k1TwHh2lzg8cBrgj15WzJZFt7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VYP9JKfS; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VYP9JKfS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRTx35HbXz2yYf;
	Tue,  1 Apr 2025 11:52:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1743468742;
	bh=OPokjJS6bZ7xjIKgUxLbF7tf4xmoAmvSOaiF5AsgPL0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VYP9JKfSVsK0aTMb6gR6csBopMOB3E6gwP/2VmBe4u9RQtCP7zmZHRTuTdCaDmlQH
	 t+MqgtQ8BTdWA4q4jZ6YB6kshqUgxEm/2jhkzlP9hMks0L8Ou2M7bjD80yFr5TMAuN
	 7dizjuCPdQINe6S+n1PPNXRHYCQeo1wbclTNplI5V8gGP74E35M++R5MSi+jxc3Jis
	 wseiy4ScWjvzxMwYtbLDyIWAD3f0Rn+1w1enAOZQDP63cYf70T6nSMRWU8szPeGgrV
	 dhsXkkCQxX448xBVMuA75/eIYz6TX+2E+lzWEDjme+2VUNwQR9vR7K7+5pL/9fKka1
	 tmdtsOu8sXuEg==
Received: from [10.194.67.88] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8BB8E7BFD0;
	Tue,  1 Apr 2025 08:52:17 +0800 (AWST)
Message-ID: <71bced05e26ae1a5f15a7335928f3f71bde143f1.camel@codeconstruct.com.au>
Subject: Re: Re: [PATCH v4 2/3] dt-bindings: pinctrl: aspeed,ast2600-pinctrl
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Willie Thai <wthai@nvidia.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dkodihalli@nvidia.com, 
	gpiccoli@igalia.com, joel@jms.id.au, kees@kernel.org, krzk+dt@kernel.org, 
	leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, robh@kernel.org, 
	tingkaic@nvidia.com, tony.luck@intel.com, harrys@nvidia.com
Date: Tue, 01 Apr 2025 11:22:16 +1030
In-Reply-To: <20250331171857.262649-1-wthai@nvidia.com>
References: 
	<d0f7003c22e19c8fc7617610043edc7be925a180.camel@codeconstruct.com.au>
	 <20250331171857.262649-1-wthai@nvidia.com>
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
MIME-Version: 1.0

Hi Willie,

On Mon, 2025-03-31 at 17:18 +0000, Willie Thai wrote:
> > > Add EMMCG5 enum to compatible list of pinctrl binding for emmc
> > > enabling.
> > >=20
> > > Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > Signed-off-by: Willie Thai <wthai@nvidia.com>
> > > ---
> > > =C2=A0.../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > | 1
> > > +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > index 80974c46f3ef..cb75e979f5e0 100644
> > > --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> > > pinctrl.yaml
> > > @@ -276,6 +276,7 @@ additionalProperties:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - BMCINT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG1
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG4
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG5
> >=20
> > What pin configuration does this correspond to for the eMMC
> > controller?
> > These groups aren't arbitrary, they correspond to the 1, 4 and 8-
> > bit
> > bus modes.
> >=20
> > You may have added this squash a warning, but I suspect the pinctrl
> > configuration in your devicetree is incorrect.
> >=20
> > Andrew
> >=20
>=20
> Thanks for your feedback !
> We want to exclude AC5 pin in the default EMMCG4 pin group, because
> that pin is used for other purpose.

Okay, sure.

> We define a new group called EMMCG5 as:
> GROUP_DECL(EMMCG5, AB4, AA4, AC4, AA5, Y5, AB5, AB6)
> The bus mode is still 4-bit mode.
> Could you please advise if we can use the name "EMMCG5" ?

Why is EMMCG5 an intuitive name? It doesn't make sense to me for what
you're trying to achieve. It's probably better if we rethink the
functions and groups to make them a little more fine-grained, perhaps

- EMMCDAT1
- EMMCDAT4
- EMMCDAT8
- EMMCWP
- EMMCCD

and then you request what's appropriate, rather than create groups that
exclude a specific function/pin (such as card detect).

Maybe you should drop the eMMC node from your devicetree for now, and
add it back once we've sorted out the pinctrl side of things in a
separate series.

Andrew

