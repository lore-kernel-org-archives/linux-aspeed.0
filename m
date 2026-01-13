Return-Path: <linux-aspeed+bounces-3309-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A141AD30CDB
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 23:31:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drQVQ2Bkgz2xqG;
	Wed, 14 Jan 2026 10:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768343392;
	cv=none; b=QkL5tYc8pDzT4JUGNjM4XhXGnv3adGnkxRZqZzS41P/t/rnUV82oG05StrRX2SsPeDQsqHx3WceyjkXXW+1M6FtNRUjesac3f2yiUJOM4x3KQsB61u6q1gM7VsBLqdkq/Q7x1Sc0+iFmkLL4vO7zBYufhcnKXBB2FirqFYyrKhqiSU5rZWhSws6uwgTqVqZneGRLq8mIa6l4XHa6gGZcQb7hKxJQtF01MnYS/WBB2NuF8dvfAZIzT5zBumFur446yn7gb9zIIN6sEo4HFBazxn5kVEpj8aH8askFJNd6NYkB9N+an4zlZ31HG3N6H5PNnd7NmQOyZYiHyyMPSlOgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768343392; c=relaxed/relaxed;
	bh=pmmfdk/VKZ1fvQfbgF33VHoYwFfmSOZu5CB3CRtPMbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdxiIkca9khh45NePFM0AhVWd7v6Q6Johc1lZz2xNjIAbvV545yqC615CaOwZ7bGMFuYF46guqGawkcwlS6rl/gb93yfRTNJ2YnvLidT507NgdXByqgXEVMHAwXL4l933m9FW2CCdOixjSclV4djflJKvF8wKokwX2ar/YUMYllRKtvQiozptVcfDImZbRARshGxyFNDeHpavHgU4pDZld9Fy7fDtjqG72B67pN7qDEtFLI5BS8eFUNNIFwV4d1m9EIHh8x63p8AV+v7QBXfhnJM9RfVNFNPFTdjGK1pJ71yWQg09e/eTfQxhgvQXSr2qA0zlgjG0k1lLaTf36Bz+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MmJT59n5; dkim-atps=neutral; spf=pass (client-ip=74.125.82.44; helo=mail-dl1-f44.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MmJT59n5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.44; helo=mail-dl1-f44.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drP7g0S04z2xpt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 09:29:50 +1100 (AEDT)
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1220154725fso233993c88.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 14:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768343327; x=1768948127; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmmfdk/VKZ1fvQfbgF33VHoYwFfmSOZu5CB3CRtPMbs=;
        b=MmJT59n5SdWVSc9GHP28fhPR2y4n0pp+UnzxhB2v4ZgRcf6CezTNhoREHd+ZtrANM3
         BftFV0QW7h0SnmucryWQVHU2HBRCvoQnuMhSufOIdGn/XuAqy+p4hb1N5tRpIYW3Slio
         iKeklVWGSoEWrF0f8rowK1ZLNRqQw0xmIxTFyB04Vp3Q4Y7D49Ss9++71GyP/m3fi3S6
         ft9+hMv7PlnddfabnTru+NGrdZtFN6Ns1dbvWyvevCT2PlD/8bfkocdZSF0Rj5L6w0IA
         Nwz04whrxOU+YP2UYFHsDWa3FmzOOxS0c8atu9jOd6NA8R3BnqbOno9/2mIifb9guHX4
         82oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768343327; x=1768948127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmmfdk/VKZ1fvQfbgF33VHoYwFfmSOZu5CB3CRtPMbs=;
        b=oX7YADwgIK2zPYBxcsWz5VEvVFADkHJzpXmJLoSyvQ/h/Jw0hPm+D2wh0XibdDKwiL
         GvP0VTEGj/iZEaH5ZSjMRsp689QFkDsqa6rwda+Kh9rsvuLrW25AbDQOnVDNbm3rT2wY
         +oMvX8Y8J3SdbeHT93Zx/8H5MSaTVaqrML+d6EhzjLLQYazBs/vkWlYJzqIv/zcQ5met
         3Btj5f++06XRs+0EC7LTdQNNsnyAaxb0D1sl2fTFx40z+UfQrQIRrRZ7IROb0Hy6LEAj
         NKBtlLzNWgP3T1NKn8+2pvUCJq5sGrL2g2tUmElVstP+u6IIy0N1J9oPTb6/YZB1vfgX
         JjNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaz4DAGvFu8p6D5+8vYFcHLqMFAGHfRToFcZMSRfFOoVJNBM4fdtG9F3WY4eZP/DeddEK1PYWUfO0XPjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxho/Tj2gUgzwF/SI+w7EWt8Kl6JL9OLFLcejrAzUPk6Mk1xIF0
	+KUAOv3wvrNeKPiWmppPETYoTseO2rzml688xILzRwvdwGplBnyzznkkpgTKoemg5MAqZ22wurV
	2Ep/IGG1gj08EEAPMT4eZk23+osgX00o=
X-Gm-Gg: AY/fxX6AQV1CI8EkPlDd4L44jvwG0guCIXkEDfudy/nV9xJ4Xfca7NR90whXTIpse2v
	WPIsDetL/seoS8yyZNRO70whgsY0bGEHlkyKAOya/JviumdHEE2qtsh60LMtAtvoDya5iQwvfQ7
	7NSiIVdVrESucMSO7Ta7WFit4DZsjBZrrR5YtkGlpNDaq2oqQz2d9feabXg1SfQ/nrYlvYfIxcT
	Z0Jp0j78rJVt3fgpsQmO0unQcmFJevJXWcW7vkgJGWpZK8U8qhDWgC1V1dbPUXRhlHe10nGuZtB
	UAORIPIk
X-Received: by 2002:a05:7022:6284:b0:121:d898:edae with SMTP id
 a92af1059eb24-12336ab1486mr479738c88.24.1768343326543; Tue, 13 Jan 2026
 14:28:46 -0800 (PST)
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
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-2-anirudhsriniv@gmail.com> <45bdf2a6c0d33dd6ce0fd3cc279ef6edc509a540.camel@codeconstruct.com.au>
 <20260112-whimsical-annoying-fulmar-25e4d9@quoll> <CAJ13v3RKydFK+sP_Cm-HnQjsOJSDyX_dsGs_Yy564V=Wc7tQFw@mail.gmail.com>
 <e97b7a193f8bbfca9ec00037808ad80a5baf9f00.camel@codeconstruct.com.au>
In-Reply-To: <e97b7a193f8bbfca9ec00037808ad80a5baf9f00.camel@codeconstruct.com.au>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Tue, 13 Jan 2026 16:28:34 -0600
X-Gm-Features: AZwV_Qj3tLQCdlXGc4mVCUHplcJiv-ygH2rDEByc1Cc6_E5RuzTQMstHuy-HUGo
Message-ID: <CAJ13v3QYWRfyivrbP=+hreHuMkYWGPkngW3kJyq6xNVL6YdpgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asus IPMI card
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew

On Mon, Jan 12, 2026 at 6:57=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Perhaps we could incorporate either of those?
>
>  * asus,e21524-ipmi-expansion-card
>  * asus,ipmi-expansion-card-r1-04
>
> However, they're not without some risk:
>
>    1. It's hard to tell whether E21524 is properly representative
>    2. R1.04 may also problematic as an AST2700-based card will likely
>       restart the numbering and risk a collision
>
> Otherwise, I guess there's:
>
>  * asus,ipmi-expansion-card-ast2600
>

There seem to be multiple revisions of this card. The photos have the
revision number printed on the board and the manuals have the E21XXX
number on them.
R1.01 - E21362 photo [1] manual[2]
R1.04 - E21524 photo [3] manual[4]

Mine is the latter. There seem to be some differences in the layout of
the different headers on the board, but the same set of headers are on
both boards. There is only one fw image on Asus's site, so I guess
they're the same from a sw point of view.

I've linked a screenshot [5] from the webui on the stock fw and it
says that the firmware model is "KOMMANDO". Asus also seems to name
the fw update file for this board KODO1140.ima (KODO is short for
KOMMANDO?, 1140 is the version number).

I looked at other Asus Motherboard onboard BMC fw updates and they
seem to be named <Mobo Model><version>.ima. Example board "Pro WS
W680M" [6], fw update name W680M1121.ima, another example board "Pro
WS W790E" [7], fw update name W7901167.ima

"asus,kommando-ipmi-expansion-card" is a bit long, so maybe we should
go with "asus,kodo-ipmi-expansion-card". SEO for either of the 2 terms
is not very good, but that's not what we're looking for here are we?

[1] https://uk.store.asus.com/media/catalog/product/9/0/90mc0ah0-mvuby0-7.j=
pg
[2] https://manuals.plus/m/8bcc92c2f7a875eda34d546e0e297d339ea55863fea0c6ab=
cf0f338cd26f299d_optim.pdf
[3] https://i.ebayimg.com/images/g/Um8AAeSw27JpOYcU/s-l1600.jpg
[4] https://dlcdnets.asus.com/pub/ASUS/mb/Add-on_card/IPMI_EXPANSION_CARD/E=
21524_IPMI_Card_QSG_V2_WEB.pdf?model=3DIPMI%20EXPANSION%20CARD
[5] https://ibb.co/kg96CsYY
[6] https://www.asus.com/us/motherboards-components/motherboards/workstatio=
n/pro-ws-w680m-ace-se/helpdesk_bios?model2Name=3DPro-WS-W680M-ACE-SE
[7] https://www.asus.com/us/motherboards-components/motherboards/workstatio=
n/pro-ws-w790e-sage-se/helpdesk_bios?model2Name=3DPro-WS-W790E-SAGE-SE

--=20
Regards
Anirudh Srinivasan

