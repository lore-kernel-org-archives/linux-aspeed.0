Return-Path: <linux-aspeed+bounces-2439-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E6ACCD192
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 14:49:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmHDL2ZYhz3cBW;
	Wed, 15 Oct 2025 01:49:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760453362;
	cv=none; b=MWy8T1svCmt9iGjpXLVnJ4snb9JgvSOHpnUSGVNNjpf8sGlIuZ1IZaLgKJYfcDzg5yUfUIlWR2VrWxb45Zg0Q0S53BwkCdUZ+eavWdHNCRbHVX79/0VuPQo+2TP3S+NSZPs6mZLBVhhPT2oLRTgwZ4Ua16ZxzoKXxY2/R1flPJY14MRyUcRLaNm99Qu90dfF9N/dj4OFxyYRS4H/4naozx7PGS3+R7GRgJ/BGPAXVV9IhCxO5ITiApYcIpgteb3iSqwS6fkKqIIGOeKuIQwhnC/l+Zs7DHrqdfZeuKVBLBWvOrJZfqXcSNzAOFR37vEOW2KFPFzjwui4x/rIyTA/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760453362; c=relaxed/relaxed;
	bh=WSEdxW8vhqoLFw4XnO2RSQdydgt5roCSWClRMQwsv5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1UIp3yALE4PYibBii2Xs1EB7jw2awfyfGNp6s83vql2kc7/bbTexbNErRutl6e41GT+KAMb6ZsabBa9u1yg4jw/1tPGP8TOQ1u8tr7lHSr42tqFUONdCes/Ii/5XtBzz3BRg4XR76Slza3vQO82HyBbqeN9xNNajUi+eOixQMFp0nrhIp772PNcS8dC7TTf3tmlNqAY0eMjoqMNUyB2gep0KpFbehivJHKDEMxz13y758b4AEBWDjewTAsueElaQZgKEWVJAEyZte6lvG0VIJdvAPtf1Rd8rqh1ut5gg2ZQ9tKJTc72ryuQWCGLw/vPps+iypLS0GRnb+/tUYEnjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nKsQcGYi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nKsQcGYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmHDJ1hb5z30M0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 01:49:19 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-77f343231fcso3388734b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453356; x=1761058156; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WSEdxW8vhqoLFw4XnO2RSQdydgt5roCSWClRMQwsv5Y=;
        b=nKsQcGYiFFX148tN4ZKT3s+zF7nAlP8RC2ZmClVt+OKxVBYxXwcE7oLXYdqGBOMzU2
         AtlqMaHMSsGQyiLCuCSUkC6qeLxfJN57umXbl7oFmslmJFSv3bfEm7fJ1Tcexfa5yQ6J
         3ZBTOkn+GRgOLel9XVsJ7ej8JDP4btMlrwnLq+dD9Jrh+ci44vo4NtIVnKJsgQhCjf+r
         VqcB5vZmo4iLbmqqmQIU4zaNb8gFlcVrwMjMG5TT1OCgwXgJa4UuAXqNdE+1DtshP8sO
         UjYPrheuio1pAniD/cLStqe+Sy3J/RiKSwbDD63fjoT6BUCpQp/mh2C7GKmUC/fMSOZK
         0TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453356; x=1761058156;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSEdxW8vhqoLFw4XnO2RSQdydgt5roCSWClRMQwsv5Y=;
        b=KEJsb+lRyFFDORMfFO/l9ZWOz/fhxnFzIZ26nJgHn022gIdgKhjgKC+o49gf8mvMGF
         46PUSFPKkWQko8t3YvlLH1rlTHXHAFWSP7PIsrvyX0Rt9F548ZmTnb/NX80CiC1fgGYL
         8RNAgl9WpEKhA81EeQTBb8p4nr54x/Jd+12hW9grjSU9ZJHhLuQXh8oPIlJpGqfy6sXE
         GoItfkknmJWmJ6CS+owYZSsHcLvLtUknXuxFF2YYNcSwIwJjptuLF4l5pPy7GzVhj/cW
         NzAyjzVdGshBAfmDnq6gaTvNAPdKplD5VyyCWodAz3vWli8ycugMvCTYue3yG6GNhwjg
         Kw7g==
X-Forwarded-Encrypted: i=1; AJvYcCU6i4bh61G9nGC3pDtdPMjEkIwnYekEibDejSt/FeNBp3bCDsW5o/eYtbvYmhiRHf1RJvBCk9CZ36rliLg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzmJ5mEM3nYTzedIPi7jfkDOrbomTEJ4rbBD+0BDe48eGdwS0iB
	0XAsCLVD9qlZw6oGA9OWGEwAQJXO/G5EYziNy1BcoiUzJm3zypVXj1+5
X-Gm-Gg: ASbGncvlWZ+rfgzJ2oy1nsj0gftiNU3y3Z3j2qfTQ/GHkCIKBGKNTUwcp9IkyHwITKV
	mvFWp8Z53wqODaocyrmMKH6A77a4QIsl8OVQ2Q/+kMBl8MjAM7oGne9Q6aMLNF2I+YVAp4cKYnB
	RMov+jPzcj7YgtWuwG5M5xiufnU/PB9UVso+rgjO9OXTadpBR0FZa7TZmfTtl9IE1IiC78/OE2x
	4SLVOPeGXQ/9YKoXq7XpRbyWdOBzyDT+X41gluiyLph3fx3i4m97yHQwjfi6VwXS9s3L5mlKGp+
	ntdObn24o1NlrrG2QXh1+3jEtzUomdSaQPXd2MTDgtDR9L0wxtp7gbMyKFtMtMtt45mKldIetIB
	vguVZSgg8rjrHwoX2S6Ag7bF6Qnax4fzjZV83gJetoUNWHrK/8CSIULCj08sOLPBJ77EDijH8yh
	1V17/E/PhwEwzERQ==
X-Google-Smtp-Source: AGHT+IHRMZjidw1IlMPsFc5xiHiThksQokSbYFWWjCCXkhTX53XdUxvSbAMrz6e0Awv6re5tpQfvqA==
X-Received: by 2002:a17:903:17cb:b0:290:7803:9e8 with SMTP id d9443c01a7336-29078030e8cmr41790895ad.48.1760453356132;
        Tue, 14 Oct 2025 07:49:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35382sm167317035ad.85.2025.10.14.07.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:49:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
Date: Tue, 14 Oct 2025 07:49:13 -0700
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
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
To: Andrew Lunn <andrew@lunn.ch>, Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tao Ren <taoren@meta.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net> <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 05:08, Andrew Lunn wrote:
> On Mon, Oct 13, 2025 at 06:15:27PM -0700, Tao Ren wrote:
>> Hi Guenter,
>>
>> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
>>>> From: Tao Ren <rentao.bupt@gmail.com>
>>>>
>>>> Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
>>>> duplicated code.
>>>>
>>>> Fuji-data64 and Fuji are identical except the BMC flash layout.
>>>>
>>>> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>>>
>>> With this patch in the mainline kernel, the Ethernet interface I use for
>>> testing does not come online when loading fuji-bmc in qemu.
>>>
>>> Reverting this patch fixes the problem.
>>>
>>> Looking into this patch,
>>>
>>>> -
>>>> -#include <dt-bindings/leds/common.h>
>>>> -#include "ast2600-facebook-netbmc-common.dtsi"
>>>> +#include "aspeed-bmc-facebook-fuji-data64.dts"
>>>>   
>>> ...
>>>> -&mac3 {
>>>> -	status = "okay";
>>>> -	phy-mode = "rgmii";
>>>> -	phy-handle = <&ethphy3>;
>>>> -	pinctrl-names = "default";
>>>> -	pinctrl-0 = <&pinctrl_rgmii4_default>;
>>>> -};
>>>
>>> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
>>> interface is now disabled. Adding it back in fixes the problem.
>>> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
>>>
>>> Was the interface disabled on purpose ?
>>>
>>> Thanks,
>>> Guenter
>>
>> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
>> feedback, because the rgmii setting is incorrect.
>>
>> I was planning to add mac3 back as soon as rgmii support is properly
>> handled in aspeed mac driver, but kindly let me know if you have other
>> suggestions.
> 
> If it is already in mainline, i don't care too much if it is wrong. We
> don't want to cause regressions.
> 
> I only object when adding new nodes which are wrong. If we keep adding
> broken nodes, there is no incentive to fix the broken driver to do the

This wasn't adding an allegedly (sorry, it worked for me) broken node,
it was removing one that worked for me all along. Obviously I do not know
if it worked (or if it is even used) on real hardware, but it worked for
the fuji-bmc qemu emulation.

Guenter


