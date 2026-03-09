Return-Path: <linux-aspeed+bounces-3633-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F9CFCA191
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Mar 2026 22:56:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVC6k0xlcz3c9l;
	Tue, 10 Mar 2026 09:56:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::429" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773081284;
	cv=pass; b=AAVvyxoasdoZ55KfKuK9P/aIdzgxoL3vXxUvKyOqgDCvv/goFd3golqPPkeLTEa3CrkHu3OOxQmHbeOX/34cDCNffG5joMB5faa49JB0cmU+hNcy4yQsrPDn6VAx+tylb+vY2jSBY1Rz6KqW4spOPUe2e1HgpOdsyUs+8vhvjvYqkAoxC56ekxIQdQebj8U8/o8O/nSlottgEBxJWN6ORBEzYVu5sQoHlFrYUQCJPNA76hi65HNSMh6MSnpTuK+kZlZ8RKOyp5XJLhGjFft8qHADc1lqZ2Ng6eZn9T/NIhbszChtuPryH7SpTAQClag7ehIamvjFpVhiij6EUiUXaw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773081284; c=relaxed/relaxed;
	bh=nrRcaBEzpRcULN7gKFTCVsNJUuuezDvP0uC3H3YtDbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0lA4oRjF200X0zr+MNmLStmgPLKdpZuy5CL6Mtd01FJRNoCwCrlDDYBfEMkZOn6NVC/XbPjjkaisGrvOVmTm0UvpbYYkZly6cEG8Uw8vPodH4wlv7fC1/fPUkM6dU1LNEtNau/q4aeDPYuX5/WUnkfDk9VrYz3QxN6/3D63EwNBs5TfK7nWbxw6v83pRrLIHgfIpwD8QRY/cfTGDprd++eXSHYE9S9/NuD1NtgZUBQ+7Plr4dfOshfM4ki3OpMG55MVcOxJAw4OjvRNo3OtKzneeYwAeqNUvCRRjIGN7tfu343ccUAiqYeYM4E3inwsckLVccR20ISX+WHL52nG8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XJ65jzi6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XJ65jzi6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV5Jz0Pbhz3c8h
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 05:34:41 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-82985f42664so2609511b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Mar 2026 11:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773081280; cv=none;
        d=google.com; s=arc-20240605;
        b=TSxNT6QcCVvyv0nWx4RpbqV/JhDWj740xoh5uCVeKIbx0Gur1rOgHnq/9zm5IgY/IN
         RDCoRzinrCYVK6wM19Hng7xKBW3Uue5lu3eiDVfnoVSCfF5DtUSmqZF+S/U+q8sfwy5t
         7/P3u3bmIdtM5q1hCJxfqbRFud2zB6l8WKtlhl8SVRARynzfk0wU5dGuV/hPve4H6E2e
         hIQ+1dePnJ/2ZiXUl4G0cnwgsZnb7BCOIy2bqcdKq20soPr1cv/UWTcM/sg0zPghB39k
         dQd6c+rOn7HMClfHeX5NMjQPPhMgn70/PehJnO4NbGkN1l5E4jW7SH3a29gl6QTKAMko
         P0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nrRcaBEzpRcULN7gKFTCVsNJUuuezDvP0uC3H3YtDbs=;
        fh=BBvSwiwcAJghrbvJkUOjtFR8QW+LN11Nhyacfl1Qitk=;
        b=MZxQmG/Wum/4Ho5kkzm+e7EUwlX0tD594xi+IdQIOqRn1yYYNoYtXPm5S1GKyz6S37
         Gr1uKWZXyF8OFp7oSsEEMNovLn5yLC/yBhgpRw60uIJ+gYuPT+GOeL6kj/BJCYbNnu8r
         wZHHoxZGRwxBq9WH0BIT0WJG7dobM3Ms14LbnWkd/J40MHt6CrFSwa89GhSHfT+bBVDP
         lkL8I8SYGouab5S9edOHeiukxTIlaX1XN+A5aTFDkIhYV+Y8LXZgVrEs4JSH+xiu5l0i
         HOuyLYG/F0/GY5+WCEQAz4Eq9G7JPCH8mtBdwka+Mq9RejwlruD49RIxyBh9SgKKO60N
         D/jg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773081280; x=1773686080; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrRcaBEzpRcULN7gKFTCVsNJUuuezDvP0uC3H3YtDbs=;
        b=XJ65jzi66Rg9UC4hsJCgQWCbrM7LDnHqNUdzBRtoppwIKKKndtTNk5XWxdEuQhRpSw
         1cQ/X1AqabpCPWHy+u+eGHk9m43hMQ2vi3sXQORiZa+QzNt0H6liCynP+1OarN2ef0Jw
         YBSk0C/JC/SXkb0xuIdefnbc05gcrYFLrsVR9ZS7sYErt0OzEvsH8pf2FLm601IRWUDo
         8Zt9Dk5t8MTrVOK50STK5x1U1aNS0eIDOhCSbFD2c4NHPAaOW46veWNw3UKhkKzwcVMr
         gRcG9WrXulnyaHlxWI5+MZ4qLcjFDXXeA7vfP/BZg6lnDmwVCZdxTrRlScWjdZ4IglD+
         pOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081280; x=1773686080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrRcaBEzpRcULN7gKFTCVsNJUuuezDvP0uC3H3YtDbs=;
        b=sD+8cMnvYOfCZeL7797/hcjEBVqZ3JYoV1ukGXHTn7aJFpD/KzF+VfxX6onJoQFbLE
         AuB7/R2n20Sz+ECPvmzpidSORlp7wI0f29DY41HHD+sTJiXG0mQFuukzgO+hm6f94FXI
         j5G5D/SFRJHzqOfTHE2e6NjjS6VcwUs55Qf6yd6LoJRDicq5T3ZTq9X/kHY31yhy87Ou
         U9cQJn+Xu2MAd0BQh4JqNIKb7Lw9xYkZ5qHeo0rMLO0MG5LuGHtX88n2oUThEOMhS2nE
         pNniyzndNef/OHeKrLZ8L2OO28FXs2MMUBMqxYjVZcQwK+x/TWNrcI0+wFUdl+9FCI2h
         OShQ==
X-Forwarded-Encrypted: i=1; AJvYcCUili537/75Vz9RobBehc36UMK4445XId6/ctWvLot3gl7So1B54CL4zxfu2BtzboMTjYF95msZSb/MsRI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4r0AHQnnLJWgdFHXRLZ12IHFzg3R+ufqgNa+9f3qIr5ZuNoE7
	6B+9H1XvQaTcwPLhebV8/xcrVMndd4L3MFpER7Pllq6eWY2QfUxg8P0EOQLgPmJyD+qDGCT2gZ+
	F1joufTzOjTWJ+D79hRTSxy4pi/xAsC4=
X-Gm-Gg: ATEYQzxPJZt+M0iQ7E1XcccLn9QqtGBSf0u4E9pjbN+Y5RtmSYhUQIAenvZL8w2eUzY
	GT0DoigrV5nl/fFGQq66ZM9d3VXb4ZKdO5XGP0ywlGtZIC5aQYuYqGOOU2v4FVUfixxWKJueqPd
	wsH9qL2FjUVAHKo4ecFWt96AokoSpHAiASO7knunUO7xOhwWsBS6QID4gMkXuLYu4HdUq6id76F
	khCVmNMKtQYRh/3bcemT/JiASa370HmaN1/0VSiwRF1nVjHoCAtpZ0qDyVdx/h1LhxuDJ9OBsRQ
	/SiD/lqHk287kJ8=
X-Received: by 2002:a05:6a00:8d4:b0:828:fba4:f738 with SMTP id
 d2e1a72fcca58-829a30cd00dmr10989334b3a.63.1773081279962; Mon, 09 Mar 2026
 11:34:39 -0700 (PDT)
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
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
 <20260223-yv5_revise_dts-v5-3-fc913e902488@gmail.com> <391b9b912492c07fd1fd7a737b7f49382d361fe2.camel@codeconstruct.com.au>
In-Reply-To: <391b9b912492c07fd1fd7a737b7f49382d361fe2.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 9 Mar 2026 11:34:21 -0700
X-Gm-Features: AaiRm50UUFPrZASIttjIHF4s9Vp0-viz-S5hm4dYkV_SMFCL3uBX0HPxRWEoCcI
Message-ID: <CABh9gBe2BcgnONwx=cmcOAsT15HgVGjxSChgFMvckTAW_8JfMQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ARM: dts: aspeed: yosemite5: Add new SGPIO line
 names and rename signal
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>, Jackson Liu <Jackson.Liu@quantatw.com>, 
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 6:41=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2026-02-23 at 19:17 +0800, Kevin Tung wrote:
> > Add new SGPIO line names for user space monitoring and event logging.
> >
> > Also rename PADDLE_BD_IOEXP_INT to ALERT_IRQ_PMBUS_PWR2_N to match
> > hardware naming. The original PADDLE_BD_IOEXP_INT is unused, so this
> > change does not affect current system functionality.
>
> Why are these two problems being solved in the one patch?
>
> https://docs.kernel.org/process/submitting-patches.html#split-changes
>
> Essentially, your use of "Also" is a bit of a red flag here.
>
Hi Andew, sorry for addressing two issues in a single patch. I will
split them into two separate patches.

> However, on the specifics, why was the PADDLE_BD_IOEXP_INT hardware
> naming wrong to begin with? What changed?
>
Originally the signal was named PADDLE_BD_IOEXP_INT by the hardware team,
but the name did not clearly reflect its actual function. After
discussion with the EE team,
it was renamed to ALERT_IRQ_PMBUS_PWR2_N to better match its use as
the PMBus PWR2 alert interrupt in the system.

> Broadly, it feels a lot like you're revising platform designs, then
> trying to make the one devicetree fit the current design, and are not
> explicitly communicating that this is what you're doing.
>
> If that _is_ what you're doing, then we can come up with much better
> schemes to handle it that aren't a constant stream of compatibility
> breaks.
>
> I need you to engage with this concern.
>
Thanks for your feedback. I realize there may be a lack of knowledge
on my side regarding the best practices here.
Could you kindly guide me on how we might implement a better approach
that avoids a constant stream of compatibility breaks?
I=E2=80=99d like to ensure we handle this correctly and align with the
expected workflow.

> From inspection, I only find patches 1, 4 and 7 of this series to be
> something I'd consider applying without further discussion.
>
Got it. Should I split patches 1, 4, and 7 into a separate series?
This would keep the current series shorter by excluding items that
don=E2=80=99t require further discussion.

Kevin
BR

