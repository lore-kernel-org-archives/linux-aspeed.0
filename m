Return-Path: <linux-aspeed+bounces-4076-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17365CD4F4A
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 23:51:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKF2K0dcxz2yRG;
	Tue, 19 May 2026 09:51:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779128164;
	cv=pass; b=Y6/fk+NWmTKaMB7UqDz6Vy/M80/4uNS3GzJa+Zb+jGgciFtvUXriNz2zvbDFFspBepq7cejNOoGUgDlji2c7qsjtw8I2WaPuXYFOXdfNdI+Wc83QUwz+aqQ6v5JPIgEfvmvTNi1XTCckxsPd/Fa2lbvnZZKnZDWFDezMDsOFc4zlmBLLFkqNqGsQrV4QBphrcQBIg42z2qIkPppnwRWpZvBhbk1OzAGOhILndNF9GPUzumgIOJES5U8/ya0oLHhrGwnvXXXt/DltYIDTykyyKfd9NyCpx9FHsDKm5fZWB6b7H/uWo7guZXO/6hsJxSlWh2n9AJoqoLSWby9eJ2rOdA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779128164; c=relaxed/relaxed;
	bh=pmFnTQUJEBfvGMlAcK3/VbLVmpdj7K5UAInNPmwJs08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmqP4FX4W8tqhdKSa9H8MDk+iw5RG8O+iCzT+Z5FlRpcSwyFYnS+958MdmFFQXoraYnyY99skfNaRtCzK0LqFBPIbsayk2HEYyehy5elsrATsBUitjn8naZuSxh33R7ZUg7MSTdXPTgEErtC+oY0hv05Rhs0p5f70LTk6UOsQciq11rKlWWT9Dgnckmxd2CvwsM58PGeF+IdaW7+3I+EXPzUoWxu3h9nh1jB0EjT+C1dQCAaH/roxF4A4xjGWJ2GZIxaOdRTybGa58bLo2jMuEbbw3wuDf8zrN5ZPVPO6oKcZA3DaJK4IQM1kcVhVC60tJDUrfqYpfCMdZrCB6KN1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oH/+1yR8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oH/+1yR8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com [IPv6:2607:f8b0:4864:20::b12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK5b65DYvz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 04:16:02 +1000 (AEST)
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-654672a6d68so2682491d50.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 11:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779128160; cv=none;
        d=google.com; s=arc-20240605;
        b=YTq+Pl8oitt57QW9gyz/7RxNcJ2HSqAVW8pp19aFRaqc6lV9ZlZMyZnjB0ptA2LvNq
         9F7ZfHZknRonT+2Sm2gaDeXRCiyUxFnt5Lh9WYSK8cr8n4xnjDwjPEI1mj+I+quU4Kcm
         tL+2ROMn+8MPTG+rW2RDDdCNZ9GmJc4iCa/Z/TwzJltUAZH2nXOH52+hTguuBS6o10Kl
         JYmC3VPhQr00O1peU1mda4/wKtND5kNXg1nUyjxlnFVhSFZWt74PggJw2hmx4UmntVJM
         B5diYXxI7f3A453UP0GgHi/HVcj1ZIt4uiamJstt4P52f7JcgWi8TxvaUnzBuoXn8xoy
         Fc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pmFnTQUJEBfvGMlAcK3/VbLVmpdj7K5UAInNPmwJs08=;
        fh=gZYiAgf2Tv9A43rQpLX4VukvU3NWGTGDB2T/JnkAWl0=;
        b=ARdy5evJkAQdxwh4ohgrsbcyTOcm4NRa530PRdX/L+1MDXLe0/WWSwaDBHp+9REWjm
         5cek/M2GMUS6a9ZkxV8TUoYcKmCm6bqXAbbU4kSoIetm/2FDtDee8meDBs7tR3tptm5q
         vcCSdK47U5lLdGLjneN626guhDWRsYxmYb8NIVelA5wIO+sW9bdMxjH/5AkDFGthKDGf
         yvaZqIJrqrjuUiUFMwMyMul4ELX5MswUfbVPJIpSVzTRvnuzwffSc/teB1OEYIwaks5O
         wO9RYS+abZnfJ68izHzB5mWhxkHQGvYPvoDQb9wlHpsyzL+DIDrVV+ctXCdpiwxfDW5U
         /o+A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128160; x=1779732960; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pmFnTQUJEBfvGMlAcK3/VbLVmpdj7K5UAInNPmwJs08=;
        b=oH/+1yR8ikzMPqwiHPb5FcsvQNXyKmLKzBqeIPhqIXrKrchCsVwNPj/Ym/OrsbwaxH
         MR/gkgKWOU/PWfVboHbjrFVxuGX0gQlkeXQ/No0tH1vwDDrOnZ+0Fjma1THPbGkvphpV
         0RjUwBfA0+AXMr7mQf8eu0EuIbu9PkKFgu03tdCOg/rMngEJyLpxdWeTuT3EuBOxAD63
         O0EfKaiTYmRVEi/bgJNR/0dTGPwigSrvnvtaXbIBc8muAaBmln8o4KiVhCj4fi/pdV/W
         2lT/VwDv3NcMb4Cnw5qvBwgGcLIo9/rGGDIdU68mluvK+cPpwJe57PTlcX/G3OJKCFhC
         bqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128160; x=1779732960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmFnTQUJEBfvGMlAcK3/VbLVmpdj7K5UAInNPmwJs08=;
        b=l833kCHqxAaAeFcRWVCI1v1Pbtxxq9/Y/xSjF+pD/0UQDMKEzlZMUigNnnbCbVvHRG
         b9Wub14sPv37XbrgnMOyoMPuNMAAkSqWZKRJAHy0SyNEzv0ymCMNStSXPWUpHfKV6a+q
         Pdqtn1EeZ7smSlZ+d2JlQcRXzajwoDzbLCC1Wo2oUbaPjd+k/OAt1fShvibD1zmorMRX
         6MPhocwhytSgV691k5tFxRww8T20eWDRPHVmyPYMVr+aJULuG0+vMv7ma+myEhcB4sfy
         u5d5xhzN5GAmqhX4n7KkFpRemWWqDFA2wJI104tuuUbCOm3lRwfGlcizwP0Rd2AB+VJf
         NtDw==
X-Forwarded-Encrypted: i=1; AFNElJ9mGfrjdCo1u/488qpsM4qI5khgRDcpoW7NcWNKcmfM7WXxbX4v3quot7DnI8B7sZ0kH50dY2yvmkDpbow=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzbVZoSYrjYM7FdTbLvFWAjmIy8JzxRzKD/b5XhijBi5NLD9Ngf
	f5RRzAvkkkVM2r198h5CJ5wXuOqmN0jwHL0QTK6El3tQ0TZwYnj9PE/AEM5KHs5muj68UJU8fE8
	aXpssiV2INkub3b2T20mkAuGyf6T0GN8=
X-Gm-Gg: Acq92OGgrPNPt3L2i+8JgUD8WK4Dg6p099dI56X+LA67adfoMWJr2i07zfCBGmlG8ej
	cKNY6hec2fXGXhJDxVPR4yVcIN4e+0c3MN5ppnPNBowDud0x2dIrG98pNmuvm+TLguXDhxxmWlD
	fR5AXKRvapm91AEjKxx23BBHhr7WsRml0S0Qkt0Kr2xr9fF2l95wI32ZJJ9dzi0vBv/17zRn0cz
	diD1XnBJrSzcwZeId1vrambZ2uLJUt1L4Pn7tL2UTuOFj2ZO56DOrXYf634sX5vIjiDYAX5rXyw
	31jYmy33
X-Received: by 2002:a05:690e:1301:b0:65e:28f3:4a5a with SMTP id
 956f58d0204a3-65e28f3509fmr15152238d50.37.1779128159777; Mon, 18 May 2026
 11:15:59 -0700 (PDT)
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
References: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
 <20260518033440.17569-3-prasanth.padarthi10@gmail.com> <ddb781dd-e117-4f9a-a5a3-94c192d8c2ef@lunn.ch>
 <CAMFFDGg++xLX+DzTnKVZRdbs=_3SrNfDydezRQgRjCBU5R3-KQ@mail.gmail.com>
In-Reply-To: <CAMFFDGg++xLX+DzTnKVZRdbs=_3SrNfDydezRQgRjCBU5R3-KQ@mail.gmail.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 18 May 2026 23:45:48 +0530
X-Gm-Features: AVHnY4LQzv2FiwHUhuNMKFFnaG37RaaFKQln7w4GleJGhC4Dsjf6HG5KpO6VTss
Message-ID: <CAMFFDGgFBs2y47draLM1B6Gm5a1y-LDQ318dsxM47J5_nFJ6Kg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary="000000000000f9375a06521b8d3f"

--000000000000f9375a06521b8d3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Understood. I will not rely only on the vendor DTB value for this.

For the next revision, I will drop rgmii-rxid and use the conservative rgmi=
i
setting unless I can provide board-level evidence that the required RGMII
delay is added by the PCB/PHY configuration.

I am arranging hardware validation for this board, and I will update the
Ethernet node only with evidence from the board/manual/logs.

Thanks,
Prasanth


On Mon, May 18, 2026 at 5:52=E2=80=AFPM Prasanth <prasanth.padarthi10@gmail=
.com>
wrote:

> Hi Andrew,
>
> Understood. I will not rely only on the vendor DTB value for this.
>
> For the next revision, I will drop rgmii-rxid and use the conservative
> rgmii setting unless I can provide board-level evidence that the required
> RGMII delay is added by the PCB/PHY configuration.
>
> I am arranging hardware validation for this board, and I will update the
> Ethernet node only with evidence from the board/manual/logs.
>
> Thanks,
> Prasanth
>
> On Mon, 18 May, 2026, 5:42=E2=80=AFpm Andrew Lunn, <andrew@lunn.ch> wrote=
:
>
>> > +&mac0 {
>> > +     status =3D "okay";
>> > +     phy-mode =3D "rgmii-rxid";
>>
>> It does not matter if this is what the vendor does, it is still wrong,
>> unless you can show the PCB is adding the delay.
>>
>>    Andrew
>>
>

--000000000000f9375a06521b8d3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><p>Hi Andrew,</p><p>Understood. I will n=
ot rely only on the vendor DTB value for this.</p><p>For the next revision,=
 I will drop <code dir=3D"ltr">rgmii-rxid</code> and use the conservative <=
code dir=3D"ltr">rgmii</code> setting unless I can provide board-level evid=
ence that the required RGMII delay is added by the PCB/PHY configuration.</=
p><p>I
 am arranging hardware validation for this board, and I will update the=20
Ethernet node only with evidence from the board/manual/logs.</p><p>Thanks,<=
br>Prasanth</p></div><br></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 18, 2026 at 5:52=
=E2=80=AFPM Prasanth &lt;<a href=3D"mailto:prasanth.padarthi10@gmail.com">p=
rasanth.padarthi10@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div dir=3D"auto"><p>Hi Andrew,</p><p>Understoo=
d. I will not rely only on the vendor DTB value for this.</p><p>For the nex=
t revision, I will drop <code dir=3D"ltr">rgmii-rxid</code> and use the con=
servative <code dir=3D"ltr">rgmii</code> setting unless I can provide board=
-level evidence that the required RGMII delay is added by the PCB/PHY confi=
guration.</p><p>I am arranging hardware validation for this board, and I wi=
ll update the Ethernet node only with evidence from the board/manual/logs.<=
/p><p>Thanks,<br>Prasanth</p></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 18 May, 2026, 5:42=E2=80=AFpm Andrew =
Lunn, &lt;<a href=3D"mailto:andrew@lunn.ch" rel=3D"noreferrer" target=3D"_b=
lank">andrew@lunn.ch</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">&gt; +&amp;mac0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0phy-mode =3D &quot;rgmii-rxid&quot;;<br>
<br>
It does not matter if this is what the vendor does, it is still wrong,<br>
unless you can show the PCB is adding the delay.<br>
<br>
=C2=A0 =C2=A0Andrew<br>
</blockquote></div>
</blockquote></div>

--000000000000f9375a06521b8d3f--

