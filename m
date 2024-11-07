Return-Path: <linux-aspeed+bounces-101-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67987D5D695
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 23:37:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xkz5B64Nvz3bmY;
	Fri,  8 Nov 2024 10:37:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731022654;
	cv=none; b=J4WsCweN9Gw+MyrWdiOmv1z7t0TILPhyyH1B4AY0fY/wOnWVmTPw6BGTmv6wHfiURhZPeAK5J2wx/fW2w5BdgzGd3onleP/VUmtFAqXzCD8Y2nbL4ssupjJEsCej1FMWZv8FoalCk7L9rQONI0F1kbKNQPCZdO6IQVAdNnbpom9equA2rjxL1E2q33oyTrrvprOq4lRvXlFfy4s5lFQEcdzZrgb0E7zfCAhx4GU5Q7p94oWH8VxEwL60Xo2Kp/LyxGELD+z7q22Wy5bnmUeBFSpUgPjLqJVNmVNsc8GH0gkuXPB/dq7I+uCNpFXWR/GtKl7sR9LuFmtJ9nimZO87qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731022654; c=relaxed/relaxed;
	bh=sB9WbFBpbPjCLPWf25Q6cNTRTz1ZxYwqcOTV66sDiIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRUvUtQHmG86Tkz9oZuj1dIdkgK/srmilwNJVpOGqUq9HtUhaWe8e5NStuyAKbUbQs/d+m8n3HbehW/j414Qy5wwEBpxmav7g3hmgyqD5SN/46/vNM+BDtE+54+iJ/ytTV9xEDsOBk3aRlxUIQ+mlprHCpNm5HONqIoRJY/0J0x79bmEnleTHAH5H3ASZRCuQ9CxiG6MSkzvjnZvkwXxU54Otc+Ej0CeCNnQiuZ2+eR4aN6YiUxDj3fYBsvd2MdEedDTyyuapNjCRfb+LWPfuqNhInQ881x8nTnSGRkWNi+xGW7gI5chdRluzxJHMo3B5p258hadP1lW4zC1RWaxMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=c8md9D9T; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=c8md9D9T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xkz5B0P1Vz2yVt
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Nov 2024 10:37:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731022653;
	bh=sB9WbFBpbPjCLPWf25Q6cNTRTz1ZxYwqcOTV66sDiIk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c8md9D9T5JUduyHph29pPdPnY7w/3iZEYl8eeCd5EOJSX66dP9k9iydIqE0HXCPyi
	 DjiCfNC4o2EFaCMetlEvYuPLeFCV++2G7k45SA7oA7t9Ziy2ihmAMjySdj5aIrCq8O
	 m4UjPv7OEbc3uBm0jZJBzHyVwA5i0oqDcc7JxyK/lzoXZ4lxLn/BPqBP5QXMV56vOD
	 7VWPQKvP0QnqVCenDj6iZDILl4LN5Aza1KJz5Kw8K1/azoqvLt5GT+z5iu9sR8Jksv
	 slHkyrZedpDOAqfsH9kjnMjTedB/oAb0AsGNjTW98Q2/os6kSm5kOqZksbBGNoofEB
	 ccB2MndkxgVzA==
Received: from [192.168.68.112] (ppp118-210-167-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.167.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C37FB6B922;
	Fri,  8 Nov 2024 07:37:31 +0800 (AWST)
Message-ID: <1c8f39015eae7cc71fbfb9136af8a728d743a991.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Patrick
 Williams <patrick@stwcx.xyz>,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Potin Lai <potin.lai@quantatw.com>, Cosmo
 Chou <cosmo.chou@quantatw.com>
Date: Fri, 08 Nov 2024 10:07:31 +1030
In-Reply-To: <CAGfYmwVxwaZk-si1OkP4xeaODhAO74Hv43U=SpzOsGOBkTH8Bw@mail.gmail.com>
References: 
	<20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
	 <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
	 <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
	 <CAGfYmwVxwaZk-si1OkP4xeaODhAO74Hv43U=SpzOsGOBkTH8Bw@mail.gmail.com>
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

On Thu, 2024-11-07 at 19:22 +0800, Potin Lai wrote:
> On Thu, Nov 7, 2024 at 7:41=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Wed, 2024-11-06 at 16:58 +0800, Potin Lai wrote:
> > > Update the GPIO linename of each PDB CPLD IO expander based on
> > > latest
> > > CPLD firmware.
> >=20
> > What version is the latest CPLD firmware? What was the previous
> > version
> > with the old pin assignments?
>=20
> Because the hardware changes from EVT to DVT, the CPLD firmware
> reallocated the IOEXP pin mapping in DVT version.
> I will add more description into the commit message in the next
> version.

If you have different revisions of the board, it would seem sensible to
have separate devicetrees, one for each, rather than constantly
evolving one devicetree? Tack on an `-evt`/`-dvt` suffix as required?
From there you can always have a suffix-less dts file that #includes
the most recent board revision. See some of the Aspeed EVB devicetrees
for an example.

>=20
> >=20
> > I'm also interested in some discussion of the coordination between
> > CPLD
> > firmware, the devicetree and the BMC userspace configuration. This
> > change feels pretty painful.
>=20
> I am not from the CPLD firmware team,

I don't see why you need to be? This is a cross-component concern, and
you need to make all the pieces of the puzzle line up.

>  I only know our CPLD team was
> redesigning the entire struct which causes the huge changes of IOEXP
> pins.
>=20
> This is probably a different topic, I am curious about is it possible
> to assign the linename in userspace?
> In OpenBMC, there are many services that depend on GPIO linename, it
> will be more flexible if I can assign the linename before service
> starts.

Not that I'm aware, and to determine otherwise I'd probably need to
read the implementation as much as you :)

However, separating the devicetrees would go a long way here if the
CPLD firmware is tied to the board revision...

Andrew

