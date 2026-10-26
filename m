Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188A606A31A
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FLtFfRNo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD7vS1dQ4z2xnM;
	Tue, 27 Oct 2026 09:43:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793015098;
	cv=pass; b=CIVaKH8EIRQ9Dxp3QFHVPSV4KmwtRpxne/jlegI9+oPV/Tmv+YkjPNVKvPuTtflcT9/S5p41agS8wtxnFHb5RYzpegPHomAbRZjRJRM9Xcb9okKTiVWeS7jwQn5D8TCuJMJjylbzajX9PW7W/B7F8NKk0MlCG1Coxh2YsainfyarkmfwBq/arS/3ruK3ge5GTS0VhIV5OhfIoioGP6qHYjhNNNyarzfNaWi50E+11yvuNpWDYR1H/83aIGshnywPoo+XtASCq+FLPd/l5NTXoxP5r279LHi+pfMa/NdJsiZrDEPt8IWUVGp5zR6doNVwMuOjvYcP4U0TTUUtNsqhvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793015098; c=relaxed/relaxed;
	bh=XKElveE2tmhD80Dc1VoKGJkJ+BgCeb4wmjmDRCfM5v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8H04A5/iVAr3ZS+4kLNaBcDmHzIRJDS1f2UH/GQoUTU5soD+T0rqUa/YhPVNfHd31jbkvG+F51Yr1SZCORPl4Bye4CoRzkBE+yiJVoMSbqjTdte3Ommf1AazZcMzNJ2IqS7jGycSX90OuJZ8V4um4jgwfKxqTivyMs6uH86D3/cgW7m3duNG4u4yywYRojMnZhsVT6fUS0nmFjq0W/QflUuCMoYLG3Hs+O096uo0yF0tB/viBaL18oK92dwgwhjjhsLXqDX3J80oSOJqTf6qIJurRXOmaPnHZi19nIXPc+d6G/y1AMjz2InhKy6vQDNRCHH/MhsbYnJou8e6UmZ/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FLtFfRNo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=kavyamadarsh@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FLtFfRNo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=kavyamadarsh@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCsHW4VlCz2xSF
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 22:44:54 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so3059975a12.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 04:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793015087; cv=none;
        d=google.com; s=arc-20260327;
        b=hH5EWLO1egy920W/DgkvNueLsNdH7VE0rIvrGtybYfG7ismeJsTdkrfopKWDZKXs+x
         f5BxVvOl0k17J6o8S+TAWJ7NYyUqQnvQ3rwVDA99wK8r/MzJeVyk5dF6Tu3fpI37yTv0
         CDyCk3OotfZyxPXUxswQ7yZdP+e9OtZ2V5YmLqk55avFhix/09bQxPpwBx5vAkkluxBW
         T7Xxwxf975jPAYSMhrZsS2sA8AvCb1/WVYg/NoTf18TFiV0/GmKS3gpSbrP9ZZkh3vvt
         NA5J4PD0rjlXPYP/C7bOywudYQoFlhYv/kQDDIfH39+66dTKejR0VfNL+xuTgvCsuUox
         IHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XKElveE2tmhD80Dc1VoKGJkJ+BgCeb4wmjmDRCfM5v0=;
        fh=gmfaf8ZskMY+NAxxVi1v3Jp/eyC93KD1TKj2ACVxJ5c=;
        b=LQi9A9FT8av/7D8IjJ4jCCwhYK82Cw8RNe6XgIElAG94PQPA4/5XwTSw9QjuBi3T+L
         bIG84/CVcO/RJk5M9Iut8+F9HktHPoFx5Vk8nuJth9J3NY43EajL82FKa1a3zpsI1jzE
         0TUP5OWuthonbTpVFYg9Qb70Q+3OyBc5Ki+xSqIlV7S2gs/s+BPT4QRBITwTD3sRF/nX
         WLzdk4KiNQIlmSS2FqGqNYGmGDf6CLBwPJcv+N7yWs3fF9zPDaed6fSmNmNGvT2RUftf
         5g4lhLb73HPIM/DI1PgJtrL5OJ+nZrDtBY78WcNsRa4+DVx9QbVlyIMRPH582L5mXyFv
         CltQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793015087; x=1793619887; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKElveE2tmhD80Dc1VoKGJkJ+BgCeb4wmjmDRCfM5v0=;
        b=FLtFfRNoJQRovSaXyaBfz4z4vctP93h/dgj8P8uJWu0kMsKapCQ/5qTmkcjjVnBPoa
         bo8gudUT+X6Ur2lQ6VZS4oGNQihO6ttRTPL5xsdcsLQcxJ7lmxMsYs9z9M4WHUlit4XU
         E7umOHgJQDeg0kI9Zj/39JCnWzh3llX2X6KidxLO5THmIw1i7wcgCBFeYlUcUJC3oMG/
         jnfxxNYJ/SGQpweAwj9Yi9ThlxSQU8lA4uW4AWhGWdOY6dj/M3PN+trLqDM4Lexfix8a
         JA9mGdAdmyS48yB9hpymECYBQL7qvJNtjTwKz3OYeO26W0fA06xbTZWoJfTuRgRDYogx
         UNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015087; x=1793619887;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XKElveE2tmhD80Dc1VoKGJkJ+BgCeb4wmjmDRCfM5v0=;
        b=tTSb94Kk5ZxLc7KmVHW7biZaLIwAn288hcjvPXWuJv87c2iz323gBafD4ogoWY8W9l
         FcHpxciIGr/hbr/jUEgBuwTIaycAD2iP14SXK4jr4rj0UIzJz4OUuHTUNHV5/7Nxf9xa
         dvGBx6a/5sUouHL6gbPBjvAdID8QtvhR37YiEXCw/XgmwsaAeLgfVyJQ5nawLakmaISI
         +GtoZWmKAhMJgs4f9MPI7sFIYjzzcOFLdu8T/7otCZ9HvxGmeJ54ZS5IZlaFeGmqk3P5
         HHHl6v/DLkXB2vRKZ4HIrnaUE0x+SB0A+Qe4ZTm8K0e5lLOsoxAhGtL4J62PCYJSfzBp
         +hGw==
X-Gm-Message-State: AFq9FYJM3+q0Aq/njnf9EJrsTSON8tWUZ9ojZfGEU5Fo77WrYvC2cE1a
	gDWhw2kztZJgSIgVGqtS+zpFDpKcPsjSAOVMFAfBu7HwuNQsHGC52c2YkOTxWmz7DI0dUEF0bKz
	156F2E1cWYiy55Q4cB1PbmF53tO4mRRI=
X-Gm-Gg: AYBFou2paDXk7UiyPGLOSxTbupzNrqfujKNvK+AawnsA6fOWrB+i4HWI08d9QymIxDG
	6ZkRxqIJhrONdgzNTrY6/dgwVXdJuBVvnMgMi5jSR7n0zNK8DeK6vNAwL0+wqsRPsKNoTzW/jpd
	MEn/41uX9Xnb1MQ6MFMBW+EGvMwalg2xbgMkGRr7qy88iCNof0GN6YkkafZt+R4YTPeEP1iMCwM
	nSOtBJP05yiVTvGgJ7UG/QKvYR57TMzTghrkx/g0C/l7yKYZTJOgYei3VYgJNCcliqB0PhFzh2B
	3c7ULj4mPn3kbaBk2Mwa5aDFkz4NL9vbW7o/5YKCfSgvE/UZNJrgNG4BauMssVL2210dhXhefSQ
	VeNE3xOnpy6y2UUkmCknkdzQzZ+St+3mf6LnZ
X-Received: by 2002:a17:906:f5a4:b0:c29:5b0c:1b44 with SMTP id
 a640c23a62f3a-c46bde8ad37mr810399366b.37.1793015086263; Mon, 26 Oct 2026
 04:44:46 -0700 (PDT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAD_a9macSzuBsmmoLu2Cu1doLADvcpASFi-6ADnOvmMdgDEfHA@mail.gmail.com>
 <CAMFFDGgygzu3OdFkq6+ztZOzaFMMTdYFqtkvmOtHNovQvabXQA@mail.gmail.com>
In-Reply-To: <CAMFFDGgygzu3OdFkq6+ztZOzaFMMTdYFqtkvmOtHNovQvabXQA@mail.gmail.com>
From: KAVYA M M <kavyamadarsh@gmail.com>
Date: Mon, 26 Oct 2026 17:14:34 +0530
X-Gm-Features: AclHuK-ZuZMpJmy0NhpfcoTdHqA8e01rSGWRNsBcn8NXtkWJWjar_gpncgquiRA
Message-ID: <CAD_a9mY6MHZxNgoy1TeasO5dRFsGHjbngNhDNyVsxT=OLTW=QQ@mail.gmail.com>
Subject: Re: [OpenBMC] Guidance on Getting Started with OpenBMC and Choosing a
 Development Board
To: openbmc@lists.ozlabs.org
Cc: linux-aspeed@lists.ozlabs.org, andrew@codeconstruct.com.au, 
	changhuang.liang@starfivetech.com, Shuah Khan <skhan@linuxfoundation.org>, 
	Jani Nikula <jani.nikula@intel.com>, Vitaly Lubart <lubvital@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Usyskin <alexander.usyskin@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Breno Leitao <leitao@debian.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	James Morse <james.morse@arm.com>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Dave Penkler <dpenkler@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Julian Braha <julianbraha@gmail.com>, 
	Karthikeyan KS <karthiproffesional@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>, 
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Oskar Senft <osk@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Prasanth <prasanth.padarthi10@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004b32ce065ebcdbaf"
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000004b32ce065ebcdbaf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response.

I have doubt  if I want to work on developing  OpenBMC  image for the
machine . do I really need schematics information or the firmware .bin
alone  file give the exacted all the information .
 What are all the tests need to done before uploading the generated image
into the physical chip.

Best regards.
Kavya





On Mon, 26 Oct, 2026, 4:38=E2=80=AFpm Prasanth, <prasanth.padarthi10@gmail.=
com>
wrote:

> Hi Kavya,
>
> Thanks for sharing your platform details and starting a separate thread.
>
> I am also Working On OpenBMC through ASRock Rack B650D4U enablement.
> My work is still in progress, and I have not worked on the Gigabyte
> MZ32-AR0 or evaluated development boards within your budget, so I
> cannot recommend a specific platform confidently.
>
> For the vendor-restricted shell, I would suggest contacting Gigabyte
> support about supported debugging access and recovery procedures.
>
> My practical recovery experience is limited to the ASRock Rack B650D4U
> that I am currently working on. I use a CH341A external SPI flash
> programmer for BMC firmware recovery.
>
> I have not worked on the Gigabyte MZ32-AR0, so I cannot confirm its
> recovery procedure or programmer compatibility. Please verify the
> flash device, required voltage, and board-specific recovery
> instructions before attempting external programming.
>
> On Mon, Oct 26, 2026 at 4:07=E2=80=AFPM KAVYA M M <kavyamadarsh@gmail.com=
> wrote:
> >
> > Hello OpenBMC Team,
> >
> > I am new to OpenBMC development and would appreciate your guidance on
> getting started with developing and validating an OpenBMC image for a
> server platform.
> >
> > I have a few general questions:
> >
> > 1. What hardware documentation is normally required to develop a
> reliable OpenBMC image for a new motherboard? Are the user manual and BMC
> reference schematic sufficient, or are the complete motherboard schematic
> and board-specific signal mappings essential?
> > 2. If the original BMC firmware is available only as a binary and the
> motherboard schematic is unavailable, what is the recommended approach fo=
r
> identifying the hardware configuration and developing the initial image?
> > 3. Which existing OpenBMC reference platforms are suitable for beginner=
s
> who want to learn the Yocto/BitBake build system, device trees, machine
> configuration, sensor integration, and required services?
> > 4. Which hardware platforms provide good support for testing sensor
> monitoring, fan PWM/tachometer control, Redfish, GPIO, host power control=
,
> and power sequencing?
> > 5. Which functions can be tested in QEMU, and what hardware
> documentation and recovery facilities are necessary before proceeding wit=
h
> physical-board testing?
> >
> > Request for Guidance on Restricted BMC SSH Access
> >
> > I would also like to understand how to access the underlying Linux shel=
l
> on a BMC when SSH access is restricted by the vendor firmware.
> >
> > For example, some BMCs provide SSH access but expose only a restricted
> interface, such as SMASH-CLP, instead of a standard Linux shell. In such
> cases, what is the recommended and authorized method for accessing the
> underlying Linux environment for debugging, inspecting system
> configuration, and understanding the running services?
> >
> > Are there standard OpenBMC debugging methods or configuration options
> for enabling SSH shell access during development? If access is restricted
> by the vendor firmware, what documentation or permissions would be requir=
ed
> to investigate this further?
> >
> > My current hardware
> >
> > I currently have access to a Gigabyte MZ32-AR0-00 motherboard with an
> ASPEED AST2500 BMC.
> >
> > I am considering using this board for my OpenBMC development. However, =
I
> do not have access to the complete motherboard schematic, and some
> board-specific hardware mappings are difficult to confirm from the
> available documentation and original vendor firmware.
> >
> > I would appreciate your advice on whether this is a suitable platform
> for learning and developing OpenBMC, or whether a different,
> better-documented development platform would be a more practical starting
> point.
> >
> > Request for development-board recommendations
> >
> > My budget for purchasing a BMC development board is approximately
> =E2=82=B95,000=E2=80=93=E2=82=B910,000.
> >
> > Could you recommend a specific development board or server motherboard
> that is affordable, well documented, and preferably has an existing
> upstream OpenBMC machine configuration?
> >
> > Ideally, I would like a platform that supports learning and testing:
> >
> > - OpenBMC image building using Yocto/BitBake.
> > - Hardware sensor monitoring and integration.
> > - Fan PWM/tachometer control and cooling failsafe behavior.
> > - Redfish and other BMC management interfaces.
> > - GPIO, host power control, and power sequencing.
> > - QEMU-based software testing followed by physical-board validation.
> >
> > My preference is for a platform with an existing reference
> implementation, accessible hardware documentation, and a reliable firmwar=
e
> recovery method. Used development boards or server motherboards would als=
o
> be suitable if they are available within my budget.
> >
> > My goal is to choose the most practical platform, build and validate an
> initial OpenBMC image, and gradually learn the hardware integration proce=
ss
> before attempting to flash a physical BMC.
> >
> > I would be grateful for any recommendations on suitable hardware,
> existing reference platforms, documentation, or practical guidance from
> developers experienced in OpenBMC platform development.
> >
> > Thank you for your time and support.
> >
> > Best regards,
> > Kavya M M
>

--0000000000004b32ce065ebcdbaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank=C2=A0you for your response.<div dir=3D"auto">=C2=A0=
</div><div dir=3D"auto">I have doubt=C2=A0 if I want to work on developing=
=C2=A0 OpenBMC=C2=A0 image for the machine . do I really need schematics in=
formation or the firmware .bin alone=C2=A0 file give the exacted all the in=
formation .=C2=A0</div><div dir=3D"auto">=C2=A0What are all the tests need =
to done before uploading the generated image into the physical chip.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Best=C2=A0regards.</div><div d=
ir=3D"auto">Kavya=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, 26 Oct, 2026, 4:38=E2=80=AFpm Prasanth, &lt;<a href=3D=
"mailto:prasanth.padarthi10@gmail.com">prasanth.padarthi10@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Kavya,<br>
<br>
Thanks for sharing your platform details and starting a separate thread.<br=
>
<br>
I am also Working On OpenBMC through ASRock Rack B650D4U enablement.<br>
My work is still in progress, and I have not worked on the Gigabyte<br>
MZ32-AR0 or evaluated development boards within your budget, so I<br>
cannot recommend a specific platform confidently.<br>
<br>
For the vendor-restricted shell, I would suggest contacting Gigabyte<br>
support about supported debugging access and recovery procedures.<br>
<br>
My practical recovery experience is limited to the ASRock Rack B650D4U<br>
that I am currently working on. I use a CH341A external SPI flash<br>
programmer for BMC firmware recovery.<br>
<br>
I have not worked on the Gigabyte MZ32-AR0, so I cannot confirm its<br>
recovery procedure or programmer compatibility. Please verify the<br>
flash device, required voltage, and board-specific recovery<br>
instructions before attempting external programming.<br>
<br>
On Mon, Oct 26, 2026 at 4:07=E2=80=AFPM KAVYA M M &lt;<a href=3D"mailto:kav=
yamadarsh@gmail.com" target=3D"_blank" rel=3D"noreferrer">kavyamadarsh@gmai=
l.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello OpenBMC Team,<br>
&gt;<br>
&gt; I am new to OpenBMC development and would appreciate your guidance on =
getting started with developing and validating an OpenBMC image for a serve=
r platform.<br>
&gt;<br>
&gt; I have a few general questions:<br>
&gt;<br>
&gt; 1. What hardware documentation is normally required to develop a relia=
ble OpenBMC image for a new motherboard? Are the user manual and BMC refere=
nce schematic sufficient, or are the complete motherboard schematic and boa=
rd-specific signal mappings essential?<br>
&gt; 2. If the original BMC firmware is available only as a binary and the =
motherboard schematic is unavailable, what is the recommended approach for =
identifying the hardware configuration and developing the initial image?<br=
>
&gt; 3. Which existing OpenBMC reference platforms are suitable for beginne=
rs who want to learn the Yocto/BitBake build system, device trees, machine =
configuration, sensor integration, and required services?<br>
&gt; 4. Which hardware platforms provide good support for testing sensor mo=
nitoring, fan PWM/tachometer control, Redfish, GPIO, host power control, an=
d power sequencing?<br>
&gt; 5. Which functions can be tested in QEMU, and what hardware documentat=
ion and recovery facilities are necessary before proceeding with physical-b=
oard testing?<br>
&gt;<br>
&gt; Request for Guidance on Restricted BMC SSH Access<br>
&gt;<br>
&gt; I would also like to understand how to access the underlying Linux she=
ll on a BMC when SSH access is restricted by the vendor firmware.<br>
&gt;<br>
&gt; For example, some BMCs provide SSH access but expose only a restricted=
 interface, such as SMASH-CLP, instead of a standard Linux shell. In such c=
ases, what is the recommended and authorized method for accessing the under=
lying Linux environment for debugging, inspecting system configuration, and=
 understanding the running services?<br>
&gt;<br>
&gt; Are there standard OpenBMC debugging methods or configuration options =
for enabling SSH shell access during development? If access is restricted b=
y the vendor firmware, what documentation or permissions would be required =
to investigate this further?<br>
&gt;<br>
&gt; My current hardware<br>
&gt;<br>
&gt; I currently have access to a Gigabyte MZ32-AR0-00 motherboard with an =
ASPEED AST2500 BMC.<br>
&gt;<br>
&gt; I am considering using this board for my OpenBMC development. However,=
 I do not have access to the complete motherboard schematic, and some board=
-specific hardware mappings are difficult to confirm from the available doc=
umentation and original vendor firmware.<br>
&gt;<br>
&gt; I would appreciate your advice on whether this is a suitable platform =
for learning and developing OpenBMC, or whether a different, better-documen=
ted development platform would be a more practical starting point.<br>
&gt;<br>
&gt; Request for development-board recommendations<br>
&gt;<br>
&gt; My budget for purchasing a BMC development board is approximately =E2=
=82=B95,000=E2=80=93=E2=82=B910,000.<br>
&gt;<br>
&gt; Could you recommend a specific development board or server motherboard=
 that is affordable, well documented, and preferably has an existing upstre=
am OpenBMC machine configuration?<br>
&gt;<br>
&gt; Ideally, I would like a platform that supports learning and testing:<b=
r>
&gt;<br>
&gt; - OpenBMC image building using Yocto/BitBake.<br>
&gt; - Hardware sensor monitoring and integration.<br>
&gt; - Fan PWM/tachometer control and cooling failsafe behavior.<br>
&gt; - Redfish and other BMC management interfaces.<br>
&gt; - GPIO, host power control, and power sequencing.<br>
&gt; - QEMU-based software testing followed by physical-board validation.<b=
r>
&gt;<br>
&gt; My preference is for a platform with an existing reference implementat=
ion, accessible hardware documentation, and a reliable firmware recovery me=
thod. Used development boards or server motherboards would also be suitable=
 if they are available within my budget.<br>
&gt;<br>
&gt; My goal is to choose the most practical platform, build and validate a=
n initial OpenBMC image, and gradually learn the hardware integration proce=
ss before attempting to flash a physical BMC.<br>
&gt;<br>
&gt; I would be grateful for any recommendations on suitable hardware, exis=
ting reference platforms, documentation, or practical guidance from develop=
ers experienced in OpenBMC platform development.<br>
&gt;<br>
&gt; Thank you for your time and support.<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Kavya M M<br>
</blockquote></div>

--0000000000004b32ce065ebcdbaf--

