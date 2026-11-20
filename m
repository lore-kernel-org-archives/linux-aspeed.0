Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E8606A320
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYkBNzzc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW6dt4dK7z2yDm;
	Fri, 20 Nov 2026 18:38:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795160322;
	cv=pass; b=jJhZtfU4lYHNzKBjew9df8CQpPPJc8AWKTbHfKYVJg9TkpJi1m0rut00IoCGFxkQBQ+1oRsyc6Q/vlP3YMCRL2/P7SFHtxR7cRDVfdOUcWgNrMPBuA/gziZ8OSjC9X5LsGlPH6s0i2qOOlYJ97643yQPTB6TgYkx2wz0A6DxgPoc9smaRBF+cCXS6Ws4fdWnii8Cb8Ig8nEIlDT86dsNelLPRH3jmiVjfgfLlQxgS2uV8DbiZVz2XiFXM25g2ISQGy2xbJJVAfJoGzENhnl1gCoriytFaGF16L6897majrj9wj42ATtXgA0GgbxR0H3/hsSiFMubIC4x0Ukfer3peQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795160322; c=relaxed/relaxed;
	bh=5ij+qphomh59zfvP1thcCBpIkAgPHpODt5KxACfSPNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KO0E4GfUPzuSar8g090e6IIkR/+Jt9nMjQuUThXecvA5iYB5BBlZmbPzTEYS1k7teAKOhP/4VMM5AEvEpw+1Ga3ympQxIYqXLabP5Q8/4jQRvxQc/ubXTiNNv+FW1qjbSkN7E0d5sbaNQ9ldWHqqo0sNOqgYmP9JXRWgmH8dw8xArfDaoAhVxIPyOJPXon2wW8d8NP24u5bdZKi1KIZAOr9qA4tbKf0f6MrvO64hqDLfQqA6qN2Mls1rbjOogOkyJ3AP87vqpH0+9LWbcifqffqcbUYrKdzLGOJSj1aLAzAxd0Nrvnuj709uVekuNM7ivx/E9JHK3tqIDGW0iPVN/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYkBNzzc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYkBNzzc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com [IPv6:2607:f8b0:4864:20::b12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW6dr5dj1z2xdR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 18:38:40 +1100 (AEDT)
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-67df3b1ca06so719957d50.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 23:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795160317; cv=none;
        d=google.com; s=arc-20260327;
        b=FL6HGZT0Uxz5p57eiSLP/rR87rekLftof58CKhXkS83R6iWiKaC7xn9g9MkIIqA6EJ
         NGecrfERppPwSbim2is4JLkkIPn2sqUxsC1MNQ7eZUjlWyE8XmiYQ5+FxafHQZiaNt2X
         M+1Bej3niwBkWCxZhUtJxhVaKKRQdD7NABzhdSWw5Gie4Dlaji3x4vUKMRizvYRSIpOr
         nmSNmRJPxT7yQU/RcrhC6wPxnyoPNtDuKpTgZasVhvet8zM7DjkFNhxipMMOyu8tutqE
         dlBgvYrxPVTwOoSzhPoXqCvMg/ATm3gV2BzjMk8iGRKRAvddesCseBRkM2EGGY/Ly8ad
         9E5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5ij+qphomh59zfvP1thcCBpIkAgPHpODt5KxACfSPNg=;
        fh=eVOLKJsial39ELwQn2MW6PLi2+Z5QGtg1Rb0UNtfi84=;
        b=hZtzJnOKVlyW+HYDVudFJF7zj5Y9w0iCPhj8OWnXFOhgXMoa0lawJw0xykegZUNh3b
         2ap/UG3ZH8WgOSY4ylRcOeVPVxLfpOKFtMWQr8b9fmh3JcSdJpIpwP6dLWVNxJFmRUJL
         aWLDovvr6myl08jh7V7MM/9WWZXxfLxZH6bf9GN6Wciv6YEuIjKbfADcNzp+1pdCZtkC
         BeLxVf3T2yu3zBLYwA+nLF5gVenuQG3fXvEfRwRXxs8ADWX3eTQW98zJxFR6J12idmJm
         Wj/h3cvfXc/LQQBF8xCCxVEId5gqOg7eCrkHtbfhnPHp6NdPxZwFaQxsvf7uF79J5BfQ
         0ysw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160317; x=1795765117; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ij+qphomh59zfvP1thcCBpIkAgPHpODt5KxACfSPNg=;
        b=GYkBNzzcG8TLRDg2qTeuzjP9v/z1CSqya44dmOtMCXehyheVjLQ1/n2uxEtwnMRt+Z
         RY/DM0fuTEgBAGW4c2zKUfPuyN0qRwmD9m49v53Tv9U0zKuSg/2Ev+VqNO2wj33T+feO
         czAw0E6aRYF2hNUbKRM9N2H/7mRDunsqQDayZDnrfeLGi7HQtg9wvTf0muzwzwf6X7LM
         1wmmdTkA0YTzLYhEqt3tT/ix1yE0dd/6M5c+Ip4G95Jl4WnwIAqfoH9DhfxlstS+pJ1B
         mX1qc0zqowLQLFzzR/mEHLc2pTezwjURrQR7wgusISygwWQ5YJoLYrvRipmsAwsiYnOH
         0C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160317; x=1795765117;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ij+qphomh59zfvP1thcCBpIkAgPHpODt5KxACfSPNg=;
        b=n6mls5fS0pEDxQ2ZOEfKtrSr9MCaQOmUtVtsuGsWzn3re0xq8Fxyc/X/Qs4UlGdtaz
         jNQUgvuYN4DAM2kHjrlF+7wqR/fGNlk9QlwPbHp8oR6YFusuQx4t6TsYSgYGBw6i8iRh
         ZI6fe6eWw9BmRNRVFvaqhRPBapJuMoBuSwhuAe5LrEn+Ue5an5CE/PTnOzTZg96L+vpo
         XMvl6emVM6N+f76PbCCk4udtUmDx8A2tCVhqqAI/37I3cTBrK2rbnQAkcLjoJvoOQizL
         k5BRa5h0/4nJ1Y4ffYazi0OZmOG270rJkjMq426ZArsBI9QUgc5oAJBG5x+AqG+sPD7E
         +5/w==
X-Forwarded-Encrypted: i=1; AL+hErHIF+zIiYwcH7bnGpbzJ0ecQW7xn99BOTqsEH8UM+gWnwMVPmwVR673qq8ExDjGezNiOX+7s7EV/5KpQqc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8zBq0NIbS9y1RzYdkvB3M4+MSOPJkvXIclCT3vpiXHXdjYKVjX
	b9B0NkQeFN+1Ojm2lvKNrjlpwKWomiIfneh/cyxR6uxFkQ3kOAH5iCu6dVsiL06XdXfisBPcYkL
	CcikWE08215dEVWR6Agp7mJdmtTuQ0q4rvg==
X-Gm-Gg: AZFdTZcEsfiXXHVs8L2C+pDWC3t8+/qhAfVXt+qeWVm6ha6dKbkB0mOZwyGUwqRtcw0
	clRiLWEsKfWIA+LV1RHsJ9KecEb1lGfp4ZQG3qlS4PSMUvT4pNl59jn04bTWzMVqifbTqOdFNVB
	zF7R7pskBw90gdZ55TOMr6pitV5avX8m63Q84YVA2pGnz8/ab1QuIKgp5wm6TtrKon2WXmenB3s
	owYLeU1G3VQPInrPCiP9ypihSjJA4wrYDVIows1Rcc19ZLwRIkE8QQF4gV/hCUxQXdZ9nyPwsuR
	KMDAVZRc3aHyp8k3G5hcBtYZwFG3fIy4XCk1iW4VTrLBgVtYQwvqhDFRXropRRHi7aRTo9fV92v
	XWxTV+OmR+mQpV8KK+OaOxns11U5qFxg9pIxJgw==
X-Received: by 2002:a05:690e:440f:b0:67a:5ed4:9507 with SMTP id
 956f58d0204a3-67df4496b89mr665195d50.93.1795160317246; Thu, 19 Nov 2026
 23:38:37 -0800 (PST)
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
References: <CAMFFDGivXPRLWNVY-g1ngfUXiHRCFPfn5uAOy71mtpi+J2=M9A@mail.gmail.com>
 <KL1PR0601MB3986A356BD06F98D0FF9AD5E80792@KL1PR0601MB3986.apcprd06.prod.outlook.com>
In-Reply-To: <KL1PR0601MB3986A356BD06F98D0FF9AD5E80792@KL1PR0601MB3986.apcprd06.prod.outlook.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Fri, 20 Nov 2026 13:08:25 +0530
X-Gm-Features: AclHuK_fsW__HQl4_HCqWIC298aGNsw0jsDljuS5U4gQkTKXuN9IiHaI0S_KXg4
Message-ID: <CAMFFDGhB3C=UUKAKRhd6XW5gmr9Froyk-YxQhCj8FhSzYUZY4Q@mail.gmail.com>
Subject: Re: AST2600 OTP NVMEM driver: hardware clarification for v2
To: Neal Liu <neal_liu@aspeedtech.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Tan Siewert <tan.siewert@9elements.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary="00000000000006434a0660b055b6"
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000006434a0660b055b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neal,

Thank you for the detailed hardware clarifications and for agreeing to be
listed as a co-developer.

I'll incorporate these findings into v2, particularly the completion
polling, timeout handling, read-mode initialization, and SEC54
protection-range handling.

I'll also reference your public response in the patch submission and
include the Co-developed-by and Signed-off-by tags as provided.

Thanks again for your support.

Regards,
Prasanth

On Fri, 20 Nov, 2026, 1:01=E2=80=AFpm Neal Liu, <neal_liu@aspeedtech.com> w=
rote:

> Hi Prasanth,
>
> Thanks for picking this up. Answers below:
>
> 1. No erratum. Waiting 1 us after the command, then polling
>     SEC14[2
> <https://www.google.com/maps/search/SEC14%5B2?entry=3Dgmail&source=3Dg>:1=
]
> once, is enough.
> 2. SEC00 only blocks new writes to SEC04; relocking it does not abort
>    a running command. Nothing documents a safe retry, so keep your
>    current behaviour: return an error on timeout and stop issuing
>    commands.
> 3. Reads must be done in read mode. Programming leaves MR/MRA/MRB in
>    program mode. Nothing in Linux programs the OTP, so restoring read
>    mode once at probe is enough.
> 4. No documented maximum. One read takes well under 1 us, so 100 ms
>    is generous.
> 5. Yes. SEC54[5:0] uses 32-DW units, and the protected prefix is
>    max(OTPCFG0[21:16], SEC54[5:0]) * 32 DW. SEC54 can only increase
>    (SEC54[6] locks it) until ARM reset, so it may grow while Linux
>    runs. Check it on each read instead of rejecting any nonzero value.
> 6. Yes. SEC14[8
> <https://www.google.com/maps/search/SEC14%5B8?entry=3Dgmail&source=3Dg>] =
only
> reports whether the address is write-protected,
>    for programming. It does not affect reads.
>
> The datasheet is not public, so please cite this mail and public driver
> instead.
> I'm fine with being listed as co-developer:
> Co-developed-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
>
> Thanks,
> Neal
>
> ------------------------------
> *From:* Prasanth <prasanth.padarthi10@gmail.com>
> *Sent:* Saturday, November 14, 2026 4:06 PM
> *To:* Neal Liu <neal_liu@aspeedtech.com>
> *Cc:* Ryan Chen <ryan_chen@aspeedtech.com>; Billy Tsai <
> billy_tsai@aspeedtech.com>; Tan Siewert <tan.siewert@9elements.com>;
> linux-aspeed@lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>
> *Subject:* AST2600 OTP NVMEM driver: hardware clarification for v2
>
> Hi Neal and ASPEED maintainers,
>
> I am addressing Tan=E2=80=99s review of the read-only AST2600 OTP NVMEM
> driver. Could you clarify these points?
> 1. Completion polling: Why does the downstream wait_complete() require
> two successful observations of SEC14[2
> <https://www.google.com/maps/search/SEC14%5B2?entry=3Dgmail&source=3Dg>:1=
]?
> Is there an erratum or
> silicon-revision requirement?
> 2. Timeout recovery: After a command times out, can the next request
> wait for idle and retry safely? Is reset/reinitialization required?
> Can SEC00 be relocked while the command remains active?
> 3. Read initialization: Must software restore MR/MRA/MRB before
> reading? If required, should this happen once during initialization or
> before every read?
> 4. Timeout limit: What polling timeout is recommended for read and
> mode-register commands? The current 100 ms limit is an engineering
> choice, not a documented ASPEED maximum.
> 5. SEC54 range: Does SEC54[5:0] use 32-DW units, giving an effective
> protected prefix of max(OTPCFG0[21:16], SEC54[5:0]) =C3=97 128 bytes? Are
> there boundary exceptions or restrictions on changing it during Linux
> operation? The driver currently rejects nonzero SEC54 ranges.
> 6. Programming-protected reads: Are ordinary reads supported when
> SEC14[8
> <https://www.google.com/maps/search/SEC14%5B8?entry=3Dgmail&source=3Dg>] =
is
> set? Reads on my B650D4U passed, but the tested addresses
> had programming protection clear.
> A public reference or shareable guidance from the Secure Boot User
> Guide would help justify these decisions.
>
> Patch  Series:
> https://lore.kernel.org/all/20261113034213.158390-1-
> prasanth.padarthi10@gmail.com/
>
> https://lore.kernel.org/all/20261113034213.158390-2-prasanth.padarthi10@g=
mail.com/
>
> Thanks,
> Prasanth Kumar Padarthi
>

--00000000000006434a0660b055b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Neal,<div dir=3D"auto"><br></div><div dir=3D"auto">Tha=
nk you for the detailed hardware clarifications and for agreeing to be list=
ed as a co-developer.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&=
#39;ll incorporate these findings into v2, particularly the completion poll=
ing, timeout handling, read-mode initialization, and SEC54 protection-range=
 handling.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;ll also=
 reference your public response in the patch submission and include the Co-=
developed-by and Signed-off-by tags as provided.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Thanks again for your support.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Regards,</div><div dir=3D"auto">Prasanth</d=
iv></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, 20 Nov, 2026, 1:01=E2=80=AFpm Neal Liu, &l=
t;<a href=3D"mailto:neal_liu@aspeedtech.com">neal_liu@aspeedtech.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
Hi Prasanth,</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
Thanks for picking this up. Answers below:</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
1. No erratum. Waiting 1 us after the command, then polling</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0 <a href=3D"https://www.google.com/maps/search/SEC14%5B2?entry=
=3Dgmail&amp;source=3Dg">SEC14[2</a>:1] once, is enough.</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
2. SEC00 only blocks new writes to SEC04; relocking it does not abort</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0a running command. Nothing documents a safe retry, so keep you=
r</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0current behaviour: return an error on timeout and stop issuing=
</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0commands.</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
3. Reads must be done in read mode. Programming leaves MR/MRA/MRB in</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0program mode. Nothing in Linux programs the OTP, so restoring =
read</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0mode once at probe is enough.</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
4. No documented maximum. One read takes well under 1 us, so 100 ms</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0is generous.</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
5. Yes. SEC54[5:0] uses 32-DW units, and the protected prefix is</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0max(OTPCFG0[21:16], SEC54[5:0]) * 32 DW. SEC54 can only increa=
se</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0(SEC54[6] locks it) until ARM reset, so it may grow while Linu=
x</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0runs. Check it on each read instead of rejecting any nonzero v=
alue.</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
6. Yes. <a href=3D"https://www.google.com/maps/search/SEC14%5B8?entry=3Dgma=
il&amp;source=3Dg">SEC14[8</a>] only reports whether the address is write-p=
rotected,</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
=C2=A0 =C2=A0for programming. It does not affect reads.</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
The datasheet is not public, so please cite this mail and public driver ins=
tead.</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
I&#39;m fine with being listed as co-developer:</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
Co-developed-by: Neal Liu &lt;<a href=3D"mailto:neal_liu@aspeedtech.com" ta=
rget=3D"_blank" rel=3D"noreferrer">neal_liu@aspeedtech.com</a>&gt;</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
Signed-off-by: Neal Liu &lt;<a href=3D"mailto:neal_liu@aspeedtech.com" targ=
et=3D"_blank" rel=3D"noreferrer">neal_liu@aspeedtech.com</a>&gt;</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
Thanks,</div>
<div style=3D"direction:ltr;font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)">
Neal</div>
<div style=3D"direction:ltr"><a name=3D"m_2766436644894872808_x__MailOrigin=
al" rel=3D"noreferrer"></a></div>
<div style=3D"direction:ltr;font-family:Calibri,Arial,Helvetica,sans-serif;=
font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"direction:ltr;display:inline-block;width:98%">
<div style=3D"direction:ltr;font-family:Calibri,Arial,Helvetica,sans-serif;=
font-size:12pt;color:rgb(0,0,0)">
<b>From:</b> Prasanth &lt;<a href=3D"mailto:prasanth.padarthi10@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">prasanth.padarthi10@gmail.com</a>&gt;<=
br>
<b>Sent:</b> Saturday, November 14, 2026 4:06 PM<br>
<b>To:</b> Neal Liu &lt;<a href=3D"mailto:neal_liu@aspeedtech.com" target=
=3D"_blank" rel=3D"noreferrer">neal_liu@aspeedtech.com</a>&gt;<br>
<b>Cc:</b> Ryan Chen &lt;<a href=3D"mailto:ryan_chen@aspeedtech.com" target=
=3D"_blank" rel=3D"noreferrer">ryan_chen@aspeedtech.com</a>&gt;; Billy Tsai=
 &lt;<a href=3D"mailto:billy_tsai@aspeedtech.com" target=3D"_blank" rel=3D"=
noreferrer">billy_tsai@aspeedtech.com</a>&gt;; Tan Siewert &lt;<a href=3D"m=
ailto:tan.siewert@9elements.com" target=3D"_blank" rel=3D"noreferrer">tan.s=
iewert@9elements.com</a>&gt;; <a href=3D"mailto:linux-aspeed@lists.ozlabs.o=
rg" target=3D"_blank" rel=3D"noreferrer">linux-aspeed@lists.ozlabs.org</a> =
&lt;<a href=3D"mailto:linux-aspeed@lists.ozlabs.org" target=3D"_blank" rel=
=3D"noreferrer">linux-aspeed@lists.ozlabs.org</a>&gt;<br>
<b>Subject:</b> AST2600 OTP NVMEM driver: hardware clarification for v2</di=
v>
<div style=3D"direction:ltr;font-family:Calibri,Arial,Helvetica,sans-serif;=
font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-size:11pt">Hi Neal and ASPEED maintainers,=
<br>
<br>
I am addressing Tan=E2=80=99s review of the read-only AST2600 OTP NVMEM<br>
driver. Could you clarify these points?<br>
1. Completion polling: Why does the downstream wait_complete() require<br>
two successful observations of <a href=3D"https://www.google.com/maps/searc=
h/SEC14%5B2?entry=3Dgmail&amp;source=3Dg">SEC14[2</a>:1]? Is there an errat=
um or<br>
silicon-revision requirement?<br>
2. Timeout recovery: After a command times out, can the next request<br>
wait for idle and retry safely? Is reset/reinitialization required?<br>
Can SEC00 be relocked while the command remains active?<br>
3. Read initialization: Must software restore MR/MRA/MRB before<br>
reading? If required, should this happen once during initialization or<br>
before every read?<br>
4. Timeout limit: What polling timeout is recommended for read and<br>
mode-register commands? The current 100 ms limit is an engineering<br>
choice, not a documented ASPEED maximum.<br>
5. SEC54 range: Does SEC54[5:0] use 32-DW units, giving an effective<br>
protected prefix of max(OTPCFG0[21:16], SEC54[5:0]) =C3=97 128 bytes? Are<b=
r>
there boundary exceptions or restrictions on changing it during Linux<br>
operation? The driver currently rejects nonzero SEC54 ranges.<br>
6. Programming-protected reads: Are ordinary reads supported when<br>
<a href=3D"https://www.google.com/maps/search/SEC14%5B8?entry=3Dgmail&amp;s=
ource=3Dg">SEC14[8</a>] is set? Reads on my B650D4U passed, but the tested =
addresses<br>
had programming protection clear.<br>
A public reference or shareable guidance from the Secure Boot User<br>
Guide would help justify these decisions.<br>
<br>
Patch=C2=A0 Series:<br>
<a href=3D"https://lore.kernel.org/all/20261113034213.158390-1-" id=3D"m_27=
66436644894872808OWA36a81e87-7b88-6183-990c-c69ba097ecdd" target=3D"_blank"=
 rel=3D"noreferrer">https://lore.kernel.org/all/20261113034213.158390-1-</a=
><br>
<a href=3D"http://prasanth.padarthi10@gmail.com/" target=3D"_blank" rel=3D"=
noreferrer">prasanth.padarthi10@gmail.com/</a><br>
<a href=3D"https://lore.kernel.org/all/20261113034213.158390-2-prasanth.pad=
arthi10@gmail.com/" id=3D"m_2766436644894872808OWA9fdb256b-c5c5-e7ae-07bc-b=
11d21b60a70" target=3D"_blank" rel=3D"noreferrer">https://lore.kernel.org/a=
ll/20261113034213.158390-2-prasanth.padarthi10@gmail.com/</a><br>
<br>
Thanks,<br>
Prasanth Kumar Padarthi</div>
</div>

</blockquote></div>

--00000000000006434a0660b055b6--

