Return-Path: <linux-aspeed+bounces-4592-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22A6C54FD2
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Jul 2026 02:54:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Ygl0KMVz2xwH;
	Thu, 30 Jul 2026 12:54:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785380050;
	cv=none; b=iX4lAkLvTvk0GpuJEcDkgDRaQyC7E6dXESl2zxCbf+GxJSU4J1hX0JkYJ4nFgBR7kAp/bKYaO67z6u7ZzYb58wauFEsg5QVWqDXIZo2ayUjumw2ngxyRGDxdIkBSmL1g7t6IklTuLmBV5UgEmayGK9QQpoa/uG59rqfJM1mm+EGk+4PpibOuHNIuuGwhOFEJJv+/p7WsuBuAUbcXoa0Q++WmuwUbA7he8L9rXPJINXDZNKx88buQmHQgzonTquRKL/olgR++DKB7mAEVOWIBu6S1y3oEx2D/K+tVxQkC2NxGFfZ8f0MTWCk5V66IFXcVc7ibklq8cTIGNy1eAA4jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785380050; c=relaxed/relaxed;
	bh=DvhzTaFF4mKlbah7teVvLdI5FxseT4MERMwxNhSA5W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYRD2k2+evw6oj+Eapr0rX9qnJdo04k/0Vv41FUeqUQqBzNqwgioq8Dp5b9pcxq45GD0DcklH7IyWxZlKTbxylfCnDqZU6heosLuvbYeNkSegpt9WE1xReCOdYdcHjAkVtCsWI8y4cITgP4teit9Jx7S1P6+wqbndoWU14Yni/l8SaEH2ZmDuLPNn4YQq6/LH2OjIwV1oAY/d7W1cv6CDXrhC1LpvXJ1PptGP5TN515QMmMGCy6vHhi3WOrSPZLaxOA+rgIBxrr888qME/3JojNF+IK94xXezGAQUG/DMJO+8Kkiu4doSFmLDFCblC+niG7Mx0mrOzTAEwynJQhGOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XbLnlzWG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XbLnlzWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Ygh6plcz2xnp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jul 2026 12:54:07 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-84847482584so204350b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785380045; x=1785984845; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvhzTaFF4mKlbah7teVvLdI5FxseT4MERMwxNhSA5W8=;
        b=XbLnlzWGGdXU4aD/7vj+XlZNI7Cw5nMeyb/Ksyt7kyhi7hsKgqag05Y7ZEN/BUM7vB
         SVMh1ZaeXML1ZNifrgT4sbVHoIh2JTGIY0HwplJ6n93mHfkbfelbbrFopDgYF1kRFxM2
         XhqA1bbY0hJPzoVSVImW0L4pkCwaEQuYRefh8rOXIycn6boWMio+aL289WMeEQjM/pV9
         yEQ38AckKwIH3onP7w1I7e6YQhA1GYbni6vCOXl5fQ4dqFtO+WUrP4E89Q8G00KANcoU
         6vnOp1KC6pySgDfvIhcEADTyhFSN87hK5ZGLrdhZ3Ihgg819fswYWf1H+lwB23ML8wRd
         cTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785380045; x=1785984845;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DvhzTaFF4mKlbah7teVvLdI5FxseT4MERMwxNhSA5W8=;
        b=P+qiigRolWYCDwQiUBAPXgpQ/98V+8R0ybmfyTRBv53f8NyUDZNo6yobX3el/AZhKk
         63byFxvcc314pJ9VqHDxR02UwrPMTHC68C+9erXKHUMQY3QQu77281S9uYehG8HsFdsU
         mbhTDNv930TzFQU0g6hnizssHIs1rxrdKTrJvrXO0g+Zxn+iZws/SG5N62fFxizm4R0f
         HHZw0DtipLbV52iJLqMMKga4WrLn0VJOyKqgVX3tOgkLLT+LYXTWa9F26F1A3mYVdD+j
         JWTMhGCeq4O3H5QfvsOhNxiHMRexINKRuOyfP7PXrOd8Bv8n1hZTW7Wnx1EMoMhqjTTp
         Jc0g==
X-Forwarded-Encrypted: i=1; AHgh+Rr0KWWORzH11J3irHNleeh3qtaC9kSfvfP6331qby6v67bnx8e105/kVlHIQSxu2voJd8Vbw77ztpRU71g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzho9+LUvo/KDReCPwGJAHgykfH0tb9dyTlEmDZXo4oXRE2rgTD
	Z5e4vktQqfzdrfBGGNdXwAJdlbB3BMCkAULQQx9vwq/3moLwDV1QdT5V
X-Gm-Gg: AR+sD12d2h8Z9Y2PiUeLbnG3hXmW7o06rCDL+8naLOCcHkjSEapWEgIkcC8s1yO9rRC
	D78tNWLdYRLppq4qp6d/8jp+DapQCXBlsqcSEeLg4HxRjJ9/EEKcTqn7DjDEEQNVs19sSGojDEi
	DlPiNX6zrsMbeSash5caLUM/d5wLSh9BZqeZaH6i81Q77R3eRogButjYLMsST/m7rtHLY0rpS9T
	O2FquWcFDV/+24/Tt5/PAiJPZ+/TDpI0ub0CVIU8LJTvHlAuPFx7kfUq+dARArUNHMQ4ovsISVk
	hWrCHNqpl3d3FKI5xwPxtzhWKfssFehOiInBfpRaLAtW41SsjLcAj5jfeDD58nsmY6434BT3Ygo
	w3YWAILVAVH4Bkpve8UzTf6pFnUsG5iv1g0yeund0wwmbR8Y2s8qPBoYUNqSJGmZf3hmzdqfWuu
	yC5foQerhISakbmjFt3IODF4awUww+Em65dyGXVg4WZ+0jryH0HYh3Z/ec3pmOOAGmcOjAGsVYv
	02WmbOUHTBZE2OYgg18rEKH5wkKuFXYvR6vJw==
X-Received: by 2002:a05:6a00:428c:b0:847:9d6c:a56d with SMTP id d2e1a72fcca58-84ebde78871mr496822b3a.12.1785380045338;
        Wed, 29 Jul 2026 19:54:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0301b3csm2148213b3a.34.2026.07.29.19.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 19:54:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c175bc7b-aa9a-409e-ba89-b04ecc38dfb7@roeck-us.net>
Date: Wed, 29 Jul 2026 19:54:02 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hwmon: remove tautological dependency expressions
 from Kconfig
To: Laszlo Ersek <laszlo.ersek@arm.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Cristian Marussi <cristian.marussi@arm.com>, Heiko Stuebner
 <heiko@sntech.de>, Joel Stanley <joel@jms.id.au>,
 Sudeep Holla <sudeep.holla@kernel.org>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260729215436.2103380-1-laszlo.ersek@arm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260729215436.2103380-1-laszlo.ersek@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 14:54, Laszlo Ersek wrote:
> Commit 554b3529fe01 ("thermal/drivers/core: Remove the module Kconfig's
> option") [1] obviated some of the "Optional dependencies" (as described in
> "Documentation/kbuild/kconfig-language.rst") in "drivers/hwmon/Kconfig".
> 
> Namely, said commit restricted the valid/possible subset of the full
> Cartesian product "CONFIG_THERMAL x CONFIG_THERMAL_OF" to
> 
>    { (n, n), (y, n), (y, y) }
> 
> through "drivers/thermal/Kconfig". Numerically (using tristate values),
> this set can be expressed as:
> 
>    { (0, 0), (2, 0), (2, 2) }
> 
> Over this set, the "drivers/hwmon/Kconfig" tristate expression
> 
>    THERMAL || !THERMAL_OF
> 
> or equivalently,
> 
>    max(THERMAL, 2-THERMAL_OF)
> 
> invariably evaluates to "y" (2).
> 
> Similarly, with THERMAL having been restricted to
> 
>    { n, y }
> 
> or numerically,
> 
>    { 0, 2 }
> 
> the "drivers/hwmon/Kconfig" tristate expression
> 
>    THERMAL || THERMAL=n
> 
> or equivalently,
> 
>    max(THERMAL, THERMAL=0)
> 
> invariably evaluates to "y" (2). (Note that "THERMAL=0" returns either "y"
> (2) or "n" (0).)
> 
> Commit f37353320ee9 ("hwmon/drivers/core: Simplify complex dependency")
> [2], which is the final commit of the series that [1] is the beginning of,
> cleaned up the hwmon C source code in fact; however, it missed the
> now-collapsed dependencies in Kconfig. At the time of [2], six of today's
> such dependencies were present in Kconfig. Since then, two more have been
> added (such that they persist, anyway): one by commit 4f8d374b770a
> ("hwmon: (max6650) add thermal cooling device capability"), which was
> independent of the above-noted series, and another by commit 9855caf5d4eb
> ("hwmon: add driver for the hwmon parts of qnap-mcu devices"), which was a
> descendant of the series.
> 
> Remove these always-"y" dependencies.
> 

Dependencies such as "THERMAL || THERMAL=n" were supposed to enable the
driver to be built as module or into the kernel if THERMAL=n, and to
force it to be built as module if THERMAL=m. However, both THERMAL
and THERMAL_OF are boolean, so this really does not make sense.

Applied.

Thanks,
Guenter


