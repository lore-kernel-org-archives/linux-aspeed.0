Return-Path: <linux-aspeed+bounces-2948-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D18CEE35A
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 22:11:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9zMw20srz2yvZ;
	Wed, 19 Nov 2025 09:11:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763452235;
	cv=none; b=F2v0SK4K9l5iySeLWGVoPX85W8kAXPaf32pJuApHfgL1LVpMkKLG8+HO3GKMSy7681ml6VjZ8nDiowRAXAkBakUmNq1qaoCJSUadQCFKQlFdRjJ817Ck4LlGpfgIgEexrA6yYGM69jAAtapInt/Q6fNgjnrUdt/V+BSEkcBdzadntfSVRc1Mv9ten4Eja1G1UzryFFO+DNJvbkp4B9MHQOWyORZhbHt1ToOTRl5qTZKmvxLGpv6zUOZCFxziYFFXMAgguVQXDe+tZtaqUH6nf/rb6V38u8qsEaOYezPkI47snv+FdkQslTWiy/kWSuys3mT7LqiLpqbWly3jn79lCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763452235; c=relaxed/relaxed;
	bh=Xex7XR6jVSgg3L3vk1U6Dn6Osj6JtZek+CvCDL5wlyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTSf6l1y8AFjSzJw0/cpeWQ2wUCAajsfGAwGfbapfo56SBlc45gb/Ntp1SB64qFKDer0zeNHZG6s1x/JJ5vf4R+QQv6rHKwBp+5LpK5SG4NDAdkd8bDYadBSiZTMkrkmcQfmKT9/ZwhPPN3O1FEk3NdDTMmzZGHoOBvzeJZyHexIohQOa1NH80stJn3wSJeY3OT7DUrz6KqaT55iI1y9LvCIesfVlIbERuF0pAJGy5NQ++nnhuHHkZTc1btFXdCXzypswZJNquqt3JJfIwFfUhGS3IAADBfrj90O0HHkkQo6a9v/pHSJgpWUHkgaT5LVkCMKcEGUeVsXzHrCYyhMPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ch7vL5ZB; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ch7vL5ZB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9cGx5nGqz2xQr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 18:50:32 +1100 (AEDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-b739ef3f739so300626366b.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Nov 2025 23:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763452225; x=1764057025; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xex7XR6jVSgg3L3vk1U6Dn6Osj6JtZek+CvCDL5wlyM=;
        b=Ch7vL5ZBZGzwIApXXrLcym+QU/9c4OuiawWJL3Po5J98LE46w/dd9jR8Rqf6V63Ixt
         BOvccCbCdSW15a7p68WlNXTz6ZwDVDp61XeV4pzF42bMR5oDQhoAwcILES7LkiEm+oLY
         NBprHvpZ/W4F3DhADxF8KnDbvSyqueBo8l+MApGhViozCghZdoZkbdI9xepVF5H06QWg
         oLrUR7lYkl8Vcu1UmEdemwKAIT5oJcT770SgyjiIqXeIEmFOO1zM1+0MLE/umtdD32Za
         FtSIbbr9+hOetg1s98dnPSYWn8tU9CinKQ02jUJNdygaFmnxQihQfj7d3sCseJeA90ID
         efmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763452225; x=1764057025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xex7XR6jVSgg3L3vk1U6Dn6Osj6JtZek+CvCDL5wlyM=;
        b=Zusq6u3iplrDhYcPMPkCX98k4eQf8xFjgyxBKAOYVe3cIy7u/bu4cW8iUpP3Zsgp3w
         52KFcTHz4cEQZnpftl2ZB/24KLNbgXaP45nxVy7MQRTjsVjTEylcgKianZ2f3C3ns+pE
         vE7Y1l5st8pLWerd+aPJTRdFHOeTASt9bDc1v0+fN52sfZeWcSFV6FsMmddjTUisOBZb
         Xmv2n1rAW208d4JNfz6bojw2rYxp6sHGk+5NrSbUp7TAkRWAkJjhdTiVpCuBTlqsRjtb
         qzOde5ZKNkoZcWpoUQPMkcv5RxHk9zBHyj+gCvZ4Og4FDRaYc3CgfU0hPlN9IGddNPum
         KHTA==
X-Forwarded-Encrypted: i=1; AJvYcCXRsEnjGvuZ3pdVF9DPslIZzpx353jbauEmsAdKOS/Pa6m2fW81DJ+9ZZF5bCsOocmX0wwSQx2LQQyTZFI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxaqj+IhwZ1uJDWQKHnRrP6gxXIny2yVL0vw7+e4Azng9/X51nA
	b4zhzQkl+nZDbnWH9K2DjWk+a0JzFyNCN2oA2785xOo5sPBZF0luQEvr1Y5D6HXb8kZj8HPfXrZ
	O0F+pPxeVkRyaylaoyXk1iuj6OyTz5/0=
X-Gm-Gg: ASbGncsRayd7jLeh2PGutLiRQMM71JsKreKCzMSXGR5EGxHzRM3/uHjH7Ng9jaN50HF
	dD/Pa6BKqd/ifqpEZp18+XZ7oiZM4V9/Mt5vQfO8TohJ34SyMRG7EwCJAV8V2Zy27WwxgeFYudv
	p68qzV9cxdMN7wBfY9SCaZqj3pasTm/6lS3OdBNyfqjoBY+7pSz0jFK0SmkEaMOT0uQGaNRDkze
	KkAXLA5i5dHLsDBJgDf3wL4BaLBJjZTLd7D5hBFdiEJUlYnWWAQoAzbmUX6iA==
X-Google-Smtp-Source: AGHT+IE9v+0TlsUR7JISK8UBlFe0cUgxOnKW9XDhUTAwsDs1eLryxkWMaLTPvozR1hXBNvsus4P1W20dT14zz6inIkk=
X-Received: by 2002:a17:907:7216:b0:b73:7b5d:e781 with SMTP id
 a640c23a62f3a-b737b5de9d2mr1449305566b.48.1763452224503; Mon, 17 Nov 2025
 23:50:24 -0800 (PST)
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
References: <20251112211248.3711889-1-sjg168@gmail.com> <20251118041058.1342672-1-sjg168@gmail.com>
 <20251118041058.1342672-2-sjg168@gmail.com> <c061ee38-5026-497d-b757-b0b9db2e6729@kernel.org>
In-Reply-To: <c061ee38-5026-497d-b757-b0b9db2e6729@kernel.org>
From: Peter Shen <sjg168@gmail.com>
Date: Tue, 18 Nov 2025 02:50:13 -0500
X-Gm-Features: AWmQ_bnbEYonPjOqK-4abVH4iA619CMxk5vxL-6KmJne-B9gyNDlRjhdYRO6cQw
Message-ID: <CAJTz7Jc7esTcv8Xrfm_p-WQpj6gKaohLEdpNMnMJ8F0pqku9JQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: aspeed: Add compatible for
 Facebook Anacapa BMC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	peter.shen@amd.com
Content-Type: multipart/alternative; boundary="0000000000006b84660643d9b7a3"

--0000000000006b84660643d9b7a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for your detailed explanation. I apologize for ignoring it earlier.
I understand now about the Acked-by/Reviewed-by/Tested-by tags and the
importance of not attaching patchsets to unrelated threads.

I will make sure to follow the process correctly from now on, and also fix
my local b4 environment so that generating the proper trailers works
smoothly.

Best regards,
Peter


Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:21=E5=AF=AB=E9=81=93=EF=BC=
=9A

> On 18/11/2025 05:10, Peter Shen wrote:
> > This patch adds the compatible string for the Facebook Anacapa BMC
> > which uses an Aspeed AST2600 SoC. This is required before adding
> > the board's device tree source file.
> >
> > Signed-off-by: Peter Shen <sjg168@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>
>
> So you just ignored everything I wrote? Long explanation and you just
> don't care?
>
> If so, then:
>
> NAK,
>
> Also, do not attach (thread) your patchsets to some other threads
> (unrelated or older versions). This buries them deep in the mailbox and
> might interfere with applying entire sets. See also:
>
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/s=
ubmitting-patches.rst#L830
>
> Best regards,
> Krzysztof
>

--0000000000006b84660643d9b7a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Krzysztof,</div><div><br></div><d=
iv>Thanks for your detailed explanation. I apologize for ignoring it earlie=
r.=C2=A0=C2=A0</div><div>I understand now about the Acked-by/Reviewed-by/Te=
sted-by tags and the importance of not attaching patchsets to unrelated thr=
eads.=C2=A0=C2=A0</div><div><br></div><div>I will make sure to follow the p=
rocess correctly from now on, and also fix my local b4 environment so that =
generating the proper trailers works smoothly.</div><div><br></div><div>Bes=
t regards,</div><div>Peter</div><div><br></div></div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">Krzysztof Kozlowski &lt;<a href=3D"mailto:krzk@kernel.org">krzk@kernel.or=
g</a>&gt; =E6=96=BC 2025=E5=B9=B411=E6=9C=8818=E6=97=A5 =E9=80=B1=E4=BA=8C =
=E4=B8=8A=E5=8D=882:21=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On 18/11/2025 05:10, Peter Shen wrote:<br=
>
&gt; This patch adds the compatible string for the Facebook Anacapa BMC<br>
&gt; which uses an Aspeed AST2600 SoC. This is required before adding<br>
&gt; the board&#39;s device tree source file.<br>
&gt; <br>
&gt; Signed-off-by: Peter Shen &lt;<a href=3D"mailto:sjg168@gmail.com" targ=
et=3D"_blank">sjg168@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +<b=
r>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
<br>
<br>
So you just ignored everything I wrote? Long explanation and you just<br>
don&#39;t care?<br>
<br>
If so, then:<br>
<br>
NAK,<br>
<br>
Also, do not attach (thread) your patchsets to some other threads<br>
(unrelated or older versions). This buries them deep in the mailbox and<br>
might interfere with applying entire sets. See also:<br>
<a href=3D"https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/=
process/submitting-patches.rst#L830" rel=3D"noreferrer" target=3D"_blank">h=
ttps://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/subm=
itting-patches.rst#L830</a><br>
<br>
Best regards,<br>
Krzysztof<br>
</blockquote></div>

--0000000000006b84660643d9b7a3--

