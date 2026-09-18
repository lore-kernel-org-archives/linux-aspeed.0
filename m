Return-Path: <linux-aspeed+bounces-5030-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDD3C982D0
	for <linux-aspeed@archiver.kernel.org>; Sun, 20 Sep 2026 07:53:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hnds71PDkz2y8c;
	Sun, 20 Sep 2026 17:53:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789744510;
	cv=none; b=bx8pvNk2YKO+slLjGA/AT7rd5yAJ3JFsXhQeWHyXJ7edbXHMHPOz8TPJvSD8wWtnEUmBj5phP1BN3pO8cAv5F9g6Zpu8wgbgaEa9DcHOyBuXcH36A6xu9XsXdvjnBT3M+T4YQ3p0DNY8EYaCDZoNaxXKH94aLj7qabvMa58cS6pHdHfBGzaX8PLKvnCj/p1VBGIZGxYA4SnGFJJs1k5kWCgbxy/vC13EC+fzRCzN1BGT2At2h2MZREqZvtVvD8jZ+ekgK0bCyopg4r5uxDQ2GXe8BRujHq2nTMPnxGnwDRFWLwqr55LDeBBFOWgqTwvKm7NqKetqaqQGH8rdI3U8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789744510; c=relaxed/relaxed;
	bh=klACuV7fdAYuSy7gHXP/AwNMnEDjRFePgshatLjHrOQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g0tOnM0r8dbk96ywH0/gg2P9pEK2q3Nw4j0mlbAraUx/6VjC3PMdIjz6GJCpMf4zuWTVHJcaaJ5Cz6xGSdV2EHwSlQfjIksoG+P1gG3j5KfR7WDIIFsDoo1Qg49VjG4Cg65DjRnLXl/uJA2b6WrFbXSIPL7o+XF9U6brAewr/0gBPw5wiwRNR5+NIk9LCCcAorYsWYSiFL+p+qhZ7I9OwXDDhns5lPlw3bz3rxF58RylN/z/WeswMLP4+cJWBaW2LzpFzp5dqdY3kmZl5NG4vkGyNoTjP4TcXLmalj33LKsj3JCzOCxHlf/283+cCKZNWBc6WnWPf3BEYDpbJbXTsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DTqEyIFw; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=caDWhMiZ; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DTqEyIFw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=caDWhMiZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmblc43Wwz2xCC
	for <linux-aspeed@lists.ozlabs.org>; Sat, 19 Sep 2026 01:15:07 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOcS2636217
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 15:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	klACuV7fdAYuSy7gHXP/AwNMnEDjRFePgshatLjHrOQ=; b=DTqEyIFwhXRJLNu9
	IeYZsHOrKbXijwmdqq+ZxiPvyfet/fCUB0waQ1XFZArweh0RjYYUmoxq7nl/JEN1
	Uy5NmhOd1qusEnfpTpqRg8agzbrAvS7pZSvHR/ylobOfF2XYjSV1/YXA1xxh8us/
	0WSRuT7kO6kdLHoxx0I2EyTlfaVrjEBLOT5OPcRGUnOIkfZCR1Q/Gs7QFtUyIHF/
	pYQtElGkrqyBwxzixxweaHTo1wj2rjXG06RAMMI+IEvfVga5JiRCPKr59GAZzH1x
	JMF+HWQl287jMZVbazg42u8QTxVQ95BPg7psGMdFhgyAH+3PsFf8v+fRdN7V6mJV
	VeUpRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gry2btas2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 15:15:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f80c76e6so17559495ad.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789744502; x=1790349302; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=klACuV7fdAYuSy7gHXP/AwNMnEDjRFePgshatLjHrOQ=;
        b=caDWhMiZATrfSlKzHl+6hfxrnvCMLea5ZUVupdYe3JWtyTnBidwGym+3ZvieibQRCW
         hHMehgkBo9Cy521icnPhRao4MdJm8rsZANXpPNqu3FLT+rxCKcqLPPEnl90B9/wTLzv+
         mLW59kgoxzsskyoSJF2JJAgjx3d0PuNLBDMWgp+yyqd7998RKJ7NT97TQ+AF3hMcqHyw
         0QjDy4+iqg9TWTkeZdpF8yyrNlQcqAXbrYp78CjaMo0SWYpNPb0KDqqD9GocSDeRT5Cc
         cK4OYHPcQMlCxRdn4tJ750yPzfyX8E7f3jYtbaPXrDx2toJgxzB64mEFFKAA63H2KyZA
         aZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744502; x=1790349302;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=klACuV7fdAYuSy7gHXP/AwNMnEDjRFePgshatLjHrOQ=;
        b=1dBM9SoqD1dfLyJ5uccdpZrTGRT1DZZhDnJ4aLn4pjzY55RjUIYG1pvIwzZ8XD+bNa
         CoqHjhdlVZvI5uMuqyJF4/yPqMIIPJxebIYKbIQGAlkIzCe2EFKUSuDsAORjgSjw6+5K
         ieY3cchUB5FVaL0HM9ldF/PyaPCa31QqLPAaIxkqhls2+NugAyB78YoIXHwh49C5AHqk
         sDtjWLo1hwPsvLrN4VC1AfhjZwO2lenC0tHhPkvXPvGeVhZVKaq0YlyCWAxmbehb/R0x
         rLabLHedNPH9xkFfMpGp72pObV2Nq9cTejIBTzTLkqYWP5efBpTbgHUtShYNwXPzDoVe
         2woA==
X-Forwarded-Encrypted: i=1; AKwUvBwFiUMsVHg2sWEI6uHt5l91juuvsSgQmz77589GUQF/lSqbmle8WaMGUenQbEVK42V8tTr0yhCfETrwUyI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lGFgmmrWSRt9o+h4cyDjxPdaB/voqc7KlAttd+utx8sfzSTFn1
	/rDhXX3DNecurYo+NCkjNxwyTQpqVmJ+cZ+J7uM8xWVXruI7F/nV9CU4rPsGT72JFo+0rgeCB1B
	Ikqu33840np+x3SB1pi8BvT0MZsGTLl3NwenSZtN0ue31rUUO5LH/d9caTLyyFFjohQq/
X-Gm-Gg: AYBFou3TFdqI60+NRUADe6b2W4TZRZBzaZtjAXdtmoznK74ZOrxBYBDArCxnE1+rT4s
	D+qCLrJ8SnAUoT4D4g44HbwVcVqOs4R23j3nEspafWHjb1SVfUtfn/6PX6OsN0jn9tlmtmwCDGF
	qvScLCY+hrL6uIVy5/isAJuf2tAGp8IasbHAwKXmiHNGPRVJqMCnVJno27bLfjd0INqgkt57YvA
	R/HQ90hSH91lJl78AGKuJRHeH8O4DvxnTvCPa6v6Ruv4zAQ9SU8xZkOGXKikwzBDKgl56zkp00I
	eFFkuBlJot6ifWIN6V3TMgK/yHXLsL6qpCU1PVOflg09p6Mym1p5D8xxrUcKB6e4ocF1aI5TPN1
	GWJaqmQ==
X-Received: by 2002:a17:903:906:b0:2dd:c053:e669 with SMTP id d9443c01a7336-2ddc053e6a2mr4635005ad.47.1789744501633;
        Fri, 18 Sep 2026 08:15:01 -0700 (PDT)
X-Received: by 2002:a17:903:906:b0:2dd:c053:e669 with SMTP id d9443c01a7336-2ddc053e6a2mr4634335ad.47.1789744501092;
        Fri, 18 Sep 2026 08:15:01 -0700 (PDT)
Received: from localhost ([143.246.51.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb73db302sm10267015ad.2.2026.09.18.08.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 08:15:00 -0700 (PDT)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 23:14:35 +0800
Message-Id: <DLIJGTK5M3G0.2PNROS5SMQWNF@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Ze Huang"
 <ze.huang@oss.qualcomm.com>,
        "Alexey Brodkin" <abrodkin@synopsys.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard"
 <mripard@kernel.org>,
        "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>,
        "Joel Stanley" <joel@jms.id.au>,
        "Andrew Jeffery"
 <andrew@codeconstruct.com.au>,
        "Frank Li" <Frank.Li@nxp.com>,
        "Sascha
 Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team"
 <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Linus
 Walleij" <linusw@kernel.org>,
        "Hans de Goede" <hansg@kernel.org>,
        "Alex
 Lanzano" <lanzano.alex@gmail.com>,
        "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>,
        "Philipp Zabel"
 <p.zabel@pengutronix.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>,
        "Marian Cichy" <m.cichy@pengutronix.de>
X-Mailer: aerc 0.22.0.r10.g73f20125
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com> <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com> <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de>
In-Reply-To: <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNyBTYWx0ZWRfXyGllaye8LpyS
 W4MHCsNT/jJSocAzImIgg9FwUqucPi0h+Pooq6QpyY4XbDLxGtSMAtYl3YqKXnBNyWGuBb6ljyP
 xfY1NUzC8wkJqjoK2xAHFZu32LokWrM34L9dlbbrkiYs5WSGZIJqODtQ25oH0EceAc1+cVHpQ85
 MAdsuuvM62sMHgSowlzw6MFC7SwjAZ1qpCDy95TpUGlUqZqTL11Zh0tymHfte8qGsjtBGuorLdi
 HEgRBWsDfMmvxWi8PuDqtNyDdvAlFXwQdasrpR4e/rw3F9axA/nVuHtI+4OksDegKFqz+gvbDuh
 IZdDbNbhDYyNkd/JZhHIQZysP5gAMVpSIMqQPQ94mDT9Q24d2BOERgWNqWiWFoAovf4oWzjZiFf
 j6oAmhxTpTHBAJ2YZPqhfxqI6ipVbcRI0bc/4jr+/7J+iUuNcbAisqnk+UJS/DHcGpNWehWsg1U
 qgGY6dUdD3rzvnkrGlw==
X-Proofpoint-GUID: WZRTeg9FsZINcroQz40OQsWRrL8Vx8wg
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aad5576 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=LNnhWNgewsfctp/cwirQdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=nI5uWgR6GCbiVoZM8DwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNyBTYWx0ZWRfX/2LZroHOMZEp
 qVAuBU6PuuCahjCACNkJ0bkqUfe753ASZjMJaVvSYKvuRtJZq11fPodkovSRBvhxMQ6hakX7Kc/
 IlnSGltr2WvCHrizI0ZRk4G/T0uIp4k=
X-Proofpoint-ORIG-GUID: WZRTeg9FsZINcroQz40OQsWRrL8Vx8wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180217

On Wed Sep 16, 2026 at 2:50 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 26.07.26 um 21:42 schrieb Ze Huang:
>> Convert i.MX LCDC to explicit primary plane, CRTC and encoder objects.
>> Keep no-scaling plane check and GEM framebuffer prepare callback from
>> simple-KMS path.
>>
>> Wire the vblank lifecycle explicitly with CRTC vblank callbacks and
>> drm_crtc_vblank_on()/drm_crtc_vblank_off(). Use the old CRTC state in th=
e
>> disable path for clock unwinding so the clock reference count remains
>> paired with the previous active state.
>>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>> +

[ ... ]

>> +static void imx_lcdc_crtc_helper_atomic_flush(struct drm_crtc *crtc,
>> +					      struct drm_atomic_commit *commit)
>> +{
>> +	struct drm_crtc_state *new_crtc_state =3D drm_atomic_get_new_crtc_stat=
e(commit, crtc);
>> +	struct drm_pending_vblank_event *event =3D new_crtc_state->event;
>> +
>> +	if (!event)
>> +		return;
>> +
>> +	new_crtc_state->event =3D NULL;
>> +
>> +	spin_lock_irq(&crtc->dev->event_lock);
>> +	if (new_crtc_state->active && drm_crtc_vblank_get(crtc) =3D=3D 0)
>> +		drm_crtc_arm_vblank_event(crtc, event);
>> +	else
>> +		drm_crtc_send_vblank_event(crtc, event);
>> +	spin_unlock_irq(&crtc->dev->event_lock);
>>   }
>
> Please use drm_crtc_vblank_atomic_flush(). [1]
>
> [1]=20
> https://elixir.bootlin.com/linux/v7.2.5/source/drivers/gpu/drm/drm_vblank=
_helper.c#L51

Thanks! will follow

>
> Best regards
> Thomas
>

