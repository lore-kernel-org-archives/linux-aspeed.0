Return-Path: <linux-aspeed+bounces-4670-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1C7C5AD5A
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 23:36:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJDmc0YvYz2yVd;
	Mon, 10 Aug 2026 09:36:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786269729;
	cv=pass; b=SdVl0ukxiE8LsZUTOuoK6gVob8HLqxY0o6NF5AZ5OCMkrzc/tuG09ezFrFROhgiUVr2l3IVx2KbOIJolirU45POVDEeMjLc2+ThJz/hSgIvYOUJWPOvtw8gS9T/uZoHiIHAR1iR3QiefnR78eeiSJS62aWozGNc1c2LZ4mxjfxMLjDSnkMv8JF+q1TsL7AtP3IoT6OZyn+zju2s01w6gRpATgxKSLr7MyESguoiD/J0i62zYufXaa/jwfuhk9XTNbJD9y+kJX7jq4OTsL2KuchzxwVL7hAcL+F18/+ljKVYMlLJpEyNGlGujqrT1aQaaX1y5Vp5+N8P34pwx3iwBzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786269729; c=relaxed/relaxed;
	bh=OHSD7QJMUDNSHM5CDmApr0cnz6TMTD5FOelv/tOIfYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5DRRDasx3q4hED+VP9CRLX1HZW2CODqITQXV1RJskKujbr646vAh0TWac6NErEE0CH3/Nipq3b3OQwNCQ0TQiVmOgJctA9rRO5OOlx92NWiZwbjjjx9+yv1CxHgH6I+eDOKwTu12l6bOWtnRgxyB+CgURkVlxEWhrr+nHvgpdZ9NbHYNO7+dYd4Ofcb67JTWyw9YM+fnb5qGSdhmPh9CIusP3v7c+rHmLzFpgVvCqLNUMx5wzYBW8oVjcZ0Hdg5Go/CryPHzulD4oDmKUUr/KyVqmCyM5a+zn9AwXIJcsdppkyBbZHXgLLUymEcR7hPPDjgq4CEknUhpfQ5CnztAw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sNVXLlRp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sNVXLlRp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHthv1DsGz2xLq
	for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 20:02:05 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2cacf197759so16765145ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 03:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786269718; cv=none;
        d=google.com; s=arc-20260327;
        b=Orq107/DXSOYGGrwIgTxSDj/ewlR/QhjzBOGw0+iYwEAuYE9dkjrk4uLtoza2/OeJt
         MVMCmZ/Pt9EKXtvOBOlZ/zVRGXCRDtTjDJ4vGurbR85yl6n0RRSKIyZuUyZVcNKsiNin
         byiZW/JWZiwOTBD3kG1gkbtGsZhZQs2HPTStW57vmYgimF6AA642rwYsYbP9wlKoW2uv
         hG5evajtgOf47swYzx1FV2yt1bq/lMJdaC4c5B/3fPEAQqRgMFZBcqnqZqFMNdKF47SB
         8IZrcOql2IHTMFuRXeh1rZSStMdw5M5UYs/ca22IZNPVuExh/Ic7av0j+uhdKOu9Foen
         0kvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OHSD7QJMUDNSHM5CDmApr0cnz6TMTD5FOelv/tOIfYk=;
        fh=6kxTr05ZUcRoXwYVtriD6j+7Glzgj9Nx7nh1/CGo0Yk=;
        b=QzJ06sTssaM4e1jGjsk9UiyYMFg29riHg2fWHSriDxIFEHetVhh0+cGKDGdJ8xj6a4
         Qg7EkO0WPZCrQAGM964S3/K89QnUtzbdkvp4rlb/H6g5S1HYcbDdabFCaMz8MyRhnsla
         E6bCTIg/p3oON6MvznwQvEgUhl99t8y7VnEN60Nt6bcfCXthIDoj5QoaDwdUJwkwBN0G
         ZvjTdm8VcsCw9ndgnxCWobmgPHAUzKuWZcpBqL2wh3hlB9ggPQTbzBmqvU85fd0cBQ8/
         njRN13TojB/cCpptwM8Q7EudoVFdKt5zcSw6EtuhmQ01MpoElyCGcs9+tdTvf+NwN/o9
         CDww==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786269718; x=1786874518; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHSD7QJMUDNSHM5CDmApr0cnz6TMTD5FOelv/tOIfYk=;
        b=sNVXLlRpM0BkjkHBXSLh1DrSqIHQWy6NBUk4eChxhX39SEadWR78bdC1tuxExNhlxR
         DyvhsRE1FY+JH3jwzsm4QYPdtg0VFiyKpOm8/QQNcb+GWXIHBywsgyplCOen7vry8rCZ
         oTfih3mPduJnYWwnikpEOmshF+0YOkjK24RAOiAUySzJCahbH7Y5zwcRNq6Zd8aBRmBx
         x7lzfPFnuK7IcOaZl7VcP5aqfeFwAqNnEvuOUVrHKmkzt7361UWLGSsh9DoalMHClzo3
         ORPh+mkyDOhwoErpsG7sexLVolovZKsVSS6UzTqu2f6r/0mOfNpGDGSMk0hX4JlSptzK
         kUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786269718; x=1786874518;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OHSD7QJMUDNSHM5CDmApr0cnz6TMTD5FOelv/tOIfYk=;
        b=Bmpn5GJk2Zc/pFHCbOvLklVrtO/39zeutdHKIA01RZGQsMigg9dST9MnXIOKz+7ZY7
         TOYK0DDtFxUK+b21EPtHtJDIvGmyuM5q8P7DbZE3z+UcCHdPMx/dNND0ISOe4kryb8N4
         wCXNxdzZMuaYSLN9FmPweaoTNhwlfDotZYgz4y85KoNmFyuq2wdBnSc5SXQmh70QH5YB
         vdaD+ME7P7poKzIPkEwKYaTjs/3+GLZgxqW1mm1Tb4lhB4X2QNhzsGLsoitJ1Zg/UByQ
         BRanL1bJlhmQJ76kBtp+AQCDutZE0I+k/xo41j8Kjp53reJgZ+Z7hLWcISlrYMVjUYZJ
         Fo9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq4Uxz8HHX4cuFzzPAfyuWlYXXTvtNez2YDIYvFfu51PyT8Aui4dXfhYe70doC8Qga9f1d5374lRyP0DUk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKLI/4uBh0AAwOa0Twjx0t/4TmqJ8EzAZqqahfGBoOnRPcuBFv
	VGRRuysEEeq/Jong6A/AGAV3yDjAk/+1ppgwzf02BGq6PSc0VuEtTFSI9WssHKMF2Nkv2d4GhCc
	suoX0IJKPQwL7J6rRQvypLmFGdLdKAiE=
X-Gm-Gg: AR+sD11ffDViQrrMPLVWya0i44xCL3jbnFX17Ni1PT3pxSui6iCwiQFI6XTfNqQRK+6
	lgvTwkpCX7jcFWFsCg3FZLEMxiyGTv8E35f1pjgzAhVClB1enhUVvVzJW2nQaR7UWGjUWpSsu5f
	ef+teiix5AgfxQkRcEkpiXvhF2exsf7ODsRvG1Kdu1Dmmxgbxgw3SuFvHwWKazdbHqqfZ6FCzPa
	o0YLRIAlCQHgGQkN4dnM6uwurBl4/TThntKWVcfkJMBbZskQMA3Jp3JlE4njeGuuXUmIWSiZ/1J
	S0DQ8Nqp0GSxbVZ9b64tlkPn48bigKYjEVomEDZvu8xny/J0g+mmc+dpbT57IAXrOhMHvjRRlCE
	vgMFMNIzBleahFgl0elyz/qrujoWdLaxCGRFaC/kiuyKbd+vYkhA7HXYGioLze4bc4otu0kKi17
	zY/YyO4shOdxYT+hMB
X-Received: by 2002:a17:903:388d:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d294c223bdmr207346785ad.15.1786269718053; Sun, 09 Aug 2026
 03:01:58 -0700 (PDT)
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
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com> <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
In-Reply-To: <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sun, 9 Aug 2026 17:01:46 +0700
X-Gm-Features: AUfX_mw1KVezTWqN2z4u9TeLCw86vjeGY2Ka_ePvHYwoFPbvJwdHv2HuwDWFspk
Message-ID: <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter

Thank you for your review .

> >   irq = platform_get_irq_optional(pdev, 0);
> > +if (irq < 0 && irq != -ENXIO)
> > +        return irq;
>
> This is still wrong. If there is no pretimeout, it does not matter if there is an error.
>

If checking data->pretimeout is required here, I'd propose one of the
following approaches
let me know which one you'd prefer:

Option A (minimal diff, keep existing structure):
---------------
irq = platform_get_irq_optional(pdev, 0);
if (data->pretimeout && irq > 0) {
        ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
                                               "wdt_bark", &wdt->wdd);
        if (ret)
                return ret;

        wdt->wdd.info = &qcom_wdt_pt_info;
        wdt->wdd.pretimeout = 1;
} else {
        if (data->pretimeout && irq < 0 && irq != -ENXIO)
                return irq;

        wdt->wdd.info = &qcom_wdt_info;
}
------------------

Option B (check moved out, before the if/else):

------------------
irq = platform_get_irq_optional(pdev, 0);
if (data->pretimeout && irq < 0 && irq != -ENXIO)
        return irq;

if (data->pretimeout && irq > 0) {
        ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
                                               "wdt_bark", &wdt->wdd);
        if (ret)
                return ret;

        wdt->wdd.info = &qcom_wdt_pt_info;
        wdt->wdd.pretimeout = 1;
} else {
        wdt->wdd.info = &qcom_wdt_info;
}
----------------------

Option C (default-then-override, only look up the IRQ when pretimeout
is supported):

----------------------
wdt->wdd.info = &qcom_wdt_info;

if (data->pretimeout) {
        irq = platform_get_irq_optional(pdev, 0);
        if(irq < 0 && irq != -ENXIO)
                return irq;

        if (irq > 0){
                ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
                                                       "wdt_bark", &wdt->wdd);
                if(ret)
                        return ret;

                wdt->wdd.info= &qcom_wdt_pt_info;
                wdt->wdd.pretimeout = 1;
        }
}
-----------------------

Let me know which one you think fits best, or if you'd prefer something else.

Best regards,
Phuc

