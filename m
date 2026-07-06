Return-Path: <linux-aspeed+bounces-4417-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A2C43458
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 23:47:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvLcS2Vfzz3br5;
	Tue, 07 Jul 2026 09:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783344746;
	cv=none; b=HXQTOei4TcmFWy5l2X4BFORe/qPae+Yr4x7+tpjMwiNPbVx94IoRUG/IN1uKOvDBXUm7qiNwidg8LLead+v/At2GH3ADgyLEwZZ6KeZrU5kj6e4XmCCIr2Jc4IH4TG9/q8xyglPOtKTr7AdetkARInPca/hB0yzF+1ZYNq32IZdN63UkEybpo5vIMsOwYXeazIcsY8XdLpb2w/4rJl/hou38jQh14LCMhEZSDXhwwBbS5wB4SOBJ91L6een5Eax/NCzzdx+MSDRHnU6jCqvAoDS6AWpAttVlBtV6HYvD+xAEaGl7LnppdgDL5Smc7gznuyMvq5H6NxxPPYdSg3F9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783344746; c=relaxed/relaxed;
	bh=b0A44HOo06DPQTnDCUPqJ4UMJjyqFyasJ88lIL5lLZ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DwCn2SfXVrKWRpZWm2zXpzc4tkCGiggfj0tASHLnzNI03qC96kfp4WA0al0UKwdH9w7I3I+mKYhVckBCobWeTJACa8AJIOfO4PML1dFBkcFQCaFQEBIFIIn1GSgnL19t6cAmCfK/ldNa90bR63P+B5IduSz2Uus0khNwcMV8I6yo4hCSsxzy5NinliBLfY3ImXSr8dwILN6JhkhcRXZcP/Us2O3NY668OgF4kdT1V/CpQMV4PFytbiKo2F32SnT5KKRoEYM47fEA1TqEG3kPVXCjnQJ7v8MgCpvosbq7cxt1QrjnXqF8MOY5Fwz7jTJWQmpkFYavyUEBAxQMOk2s2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fG+3SByw; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gwN2EAPJ; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fG+3SByw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gwN2EAPJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv4zF0fntz2yVZ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 23:32:24 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxBJd238111
	for <linux-aspeed@lists.ozlabs.org>; Mon, 6 Jul 2026 13:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b0A44HOo06DPQTnDCUPqJ4UMJjyqFyasJ88lIL5lLZ8=; b=fG+3SBywJZ4CROyC
	EBkvPSthGbsziZkeQ7K40QVe4l60fKx8Uz2ijBpMSp1CBVrM+HI0Qd48bpu+Nzhi
	b04ix3wRfk0Y6Vz8Brg9AsqOEADGYxOTg6YXVxaP6tiB5K+NL9xWmAIQdcSDsoja
	45b2aDZ3euian4+uXjzxtwYvwI7wgwpW24xN4DoAEA0dPPY4VKGbbtifFuvCkpGD
	W08lRaoc5vSPjy7BTnjfbHHH1tS2o+s/64gN7WIJ9Qc5EPV85CK276mNfFiZO5Kz
	6EK8MGQwRIYJLD/vCqeLfFfNvZBogj1cBhA/mt27j0jVSHDY5xiaxoDqHwFtLlDE
	9x26Mg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t896ur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 13:32:22 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847e32ef4caso4783377b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783344741; x=1783949541; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0A44HOo06DPQTnDCUPqJ4UMJjyqFyasJ88lIL5lLZ8=;
        b=gwN2EAPJrKW0PD1J19tLIUPCXMkmBtQAJEOKANtur7ZWCcpOVHe8F4eESVhGRPvSWM
         eIpX9pcMjD3+dLzU5ZwUOvt8ax/gmF95RZde9jqt+FBNJL1bANWkdi7U4hn49H/qUNCa
         0cZkPLO3MbeM2doO938eQV+SodYD7y/U1xAHoOvQTYM0rjPmmYTlsiNWAVtxtgvQGicu
         g5f04q+ADIuGZ0wCdLFDSDE1HVOKPMp77psEXeeWBU9Z4hlXu0Rky0C500ZbSB9mBoja
         oRRT8RpJKNDFDHKCDGMwXQkdhP5KBaZOdt9bhOy8HV3BR8V0WpP9Tkk6hkegKjptNiZk
         oKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344741; x=1783949541;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0A44HOo06DPQTnDCUPqJ4UMJjyqFyasJ88lIL5lLZ8=;
        b=rpNWKc9QUNNJWdiYafr3B+/KCrC69PA3/qoN0NyD2DuFstC8P5IaGQzVHEW8if5JcS
         hEXuExTzMY1NnkC1m77PsvrsvUQhRhZi1YpW62W1PKqyq/VbUUXki9ZM6wrNbViLxtcp
         MWpJXUdLXbOLvmU8Dw/U5C7LdyxZpSYE+9o9QsOXk98P/I5HHrWNqkf7PRdFK3r4wpzv
         uyMwmW63+MxeQyKoxrjkRYX8vIJaQuKfls080Z9gkBUVxWFyc+HLEn3spkaYJv5b6xV2
         v9LLI4v6+XlgXEvuDGcnsxIf2oVRjA3WOAwis4ETb3gypZOUA0MVNkph1psDJjWmaAR9
         oNwA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+W2T/D4FNGyfMhOJvqw117w9iCDHEPDa4wepG/CCUsxiXVzwyZHpWF1h3athWiI1u/zvx0MCTm3eL+nU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzpC23K23y1hN/WSV3ha5a4Plsi9LupBdGUREh+sWL6HOlmyQwD
	bR/EE5gYX55+yfTQa3oJmJtOp9OA5nZqUXU7CoaN9F/5KAtikewJKlNDo33GCp/TWp24cr1PzJq
	4V9CvRkeWqfiXPGHRa11ruNAcR9GRh98rEzYBCODLqqB6e8v3wIFLdQSzHnFDzqdgZsTg
X-Gm-Gg: AfdE7clEzvLhoyJOnxJrS+WxuKDyMK0BTTm0n8QAIBCnYsIO1swV83zuUaP0bcoGZiH
	xh/1KRF3CDlr8ZEBP6el48w2wRP9A1HliVxdjuCmud78oW542EdqdKVQOoTXrloAQVQesJuYlqA
	Seaa4Kk7iyVolDSmls9a4S/T7pdENTTAodhllfbpHQ3iWlVd0LSXAtTyLJZV+837+pbEFemwuTG
	DfZYCLbAVtG6ZMte+Fw0prZHcqT5cLsq12RX88ul68s2Lm0RogiLvNJY9/JVyvlcgHVmwoAqwNu
	8DS4n98Vuww9sEL/SWkh4DoqQLazvpW6MzixNt7CUDnyggdCsbeQcA/SPzfFtJxaHupouJF3NkV
	XZr6DF/TY6LXYEsQ=
X-Received: by 2002:a05:6a00:c8d:b0:847:8f8a:a055 with SMTP id d2e1a72fcca58-84826bea1afmr615689b3a.17.1783344741255;
        Mon, 06 Jul 2026 06:32:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:c8d:b0:847:8f8a:a055 with SMTP id d2e1a72fcca58-84826bea1afmr615631b3a.17.1783344740650;
        Mon, 06 Jul 2026 06:32:20 -0700 (PDT)
Received: from localhost ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d82382sm3762898b3a.49.2026.07.06.06.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:32:20 -0700 (PDT)
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
Date: Mon, 06 Jul 2026 21:32:03 +0800
Message-Id: <DJRIY04KAKRH.2XJRADHKJ4G55@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/9] drm/aspeed: replace struct drm_simple_display_pipe
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
 <oleksandr_andrushchenko@epam.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com> <20260705-drm-simple-kms-removal-v1-2-b4e1ca053623@oss.qualcomm.com> <4e35e133-364a-4743-9ca0-f0799bdf28f8@suse.de>
In-Reply-To: <4e35e133-364a-4743-9ca0-f0799bdf28f8@suse.de>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX11H3NrpmT1tB
 tEBDRdfHTn6BU1/E6QPjk8WvgdMTvgpPGysiE4oDpodEtc9u2ce9J2olzNGM93RpRnnBs3/XmBK
 o995aPYHMpWL0EsU2XYCPE6Eu4oKq2U=
X-Proofpoint-GUID: 7l0gU6D1TFaqOblrNs3LWBSejMevTida
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bae66 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=OF-i8N8vVdU2NhfsQ9oA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 7l0gU6D1TFaqOblrNs3LWBSejMevTida
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX8vdkWdOPCEIQ
 Ls9Pm+BOWCB0ATLauFjYpltd72uqiMoMPRPznA3dnykKHExL9S7154PCFU4JBUY+07Q+tGP3GcK
 U53TERZ0KbEpH/iuxAeOrWD29AscumzWzoTIBS81xG30jkBiA4HwQg3CNR+DmxaYoZwRJwWPimQ
 aKhy2bLeNvgZ80htkWmJZyTyq4kI6rBwgQF0Xjc1gaJzXfYk776ejwD0SFshtYTVju43b0c2bmw
 v9kSAwJNW3NX1wit0AhPgsdPYJTKXwt2Dk0Pp7OSYCJZ6E6JvRds4fv7ETbNA2Q0D+hPcZXPqty
 DQc8CjoWWeOdzybrux/lNSyMhP87kPXWnMuCcS7pnkViWiRKzcslnmvArT3hn1fcHHQXOweHMFV
 VYq9BPwFH0edatZS42cRtJT6fdkHDToTyh9chNuhRT+5jh9hIyq/3MYyaJ5TzLBGNi56GNPQZfL
 x3uCkLVTQMTo+rXLtSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060137

On Mon Jul 6, 2026 at 4:31 PM CST, Thomas Zimmermann wrote:
> Hi,
>
> common points from my arcgpu review applied here as well. See below for=
=20
> a new other things.
>
> Am 04.07.26 um 20:31 schrieb Ze Huang:
>> Replace simple display pipe with explicit plane, CRTC and encoder
>> objects. Move callbacks to plane and CRTC helpers, with vblank handling
>> through drm_crtc_funcs.
>>
>> This removes intermediate simple-pipe layer and uses standard atomic
>> helper wiring.
>>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/aspeed/aspeed_gfx.h      |   5 +-
>>   drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 156 +++++++++++++++++++++++=
--------
>>   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
>>   3 files changed, 123 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspee=
d/aspeed_gfx.h
>> index 4e6a442c3886..a34811564c0d 100644
>> --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
>> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
>> @@ -2,7 +2,6 @@
>>   /* Copyright 2018 IBM Corporation */
>>  =20
>>   #include <drm/drm_device.h>
>> -#include <drm/drm_simple_kms_helper.h>
>>  =20
>>   struct aspeed_gfx {
>>   	struct drm_device		drm;
>> @@ -17,7 +16,9 @@ struct aspeed_gfx {
>>   	u32				throd_val;
>>   	u32				scan_line_max;
>>  =20
>> -	struct drm_simple_display_pipe	pipe;
>> +	struct drm_plane		plane;
>> +	struct drm_crtc			crtc;
>> +	struct drm_encoder		encoder;
>>   	struct drm_connector		connector;
>>   };
>>   #define to_aspeed_gfx(x) container_of(x, struct aspeed_gfx, drm)
>> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/=
aspeed/aspeed_gfx_crtc.c
>> index 7877a57b8e26..3294795c31c4 100644
>> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
>> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
>> @@ -5,6 +5,8 @@
>>   #include <linux/reset.h>
>>   #include <linux/regmap.h>
>>  =20
>> +#include <drm/drm_atomic.h>
>> +#include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_device.h>
>>   #include <drm/drm_fb_dma_helper.h>
>>   #include <drm/drm_fourcc.h>
>> @@ -12,20 +14,13 @@
>>   #include <drm/drm_gem_atomic_helper.h>
>>   #include <drm/drm_gem_dma_helper.h>
>>   #include <drm/drm_panel.h>
>> -#include <drm/drm_simple_kms_helper.h>
>>   #include <drm/drm_vblank.h>
>>  =20
>>   #include "aspeed_gfx.h"
>>  =20
>> -static struct aspeed_gfx *
>> -drm_pipe_to_aspeed_gfx(struct drm_simple_display_pipe *pipe)
>> -{
>> -	return container_of(pipe, struct aspeed_gfx, pipe);
>> -}
>> -
>
> Please create a new helper
>
>  =C2=A0 struct drm_aspeed_gfx *to_aspeed_gfx(drm_device *drm)
>
> that does the upcast.
>

Will do

>>   static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32 *bpp)
>>   {
>> -	struct drm_crtc *crtc =3D &priv->pipe.crtc;
>> +	struct drm_crtc *crtc =3D &priv->crtc;
>>   	struct drm_device *drm =3D crtc->dev;
>>   	const u32 format =3D crtc->primary->state->fb->format->format;
>>   	u32 ctrl1;
>> @@ -79,7 +74,7 @@ static void aspeed_gfx_disable_controller(struct aspee=
d_gfx *priv)
>>  =20
>>   static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
>>   {
>> -	struct drm_display_mode *m =3D &priv->pipe.crtc.state->adjusted_mode;
>> +	struct drm_display_mode *m =3D &priv->crtc.state->adjusted_mode;
>>   	u32 ctrl1, d_offset, t_count, bpp;
>>   	int err;
>>  =20
>> @@ -139,33 +134,31 @@ static void aspeed_gfx_crtc_mode_set_nofb(struct a=
speed_gfx *priv)
>>   	writel(priv->throd_val, priv->base + CRT_THROD);
>>   }
>>  =20
>> -static void aspeed_gfx_pipe_enable(struct drm_simple_display_pipe *pipe=
,
>> -			      struct drm_crtc_state *crtc_state,
>> -			      struct drm_plane_state *plane_state)
>> +static void aspeed_gfx_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +						 struct drm_atomic_commit *state)
>
> Please see my comment on arcgpu for the new naming of 'state'.
>

OK

>>   {
>> -	struct aspeed_gfx *priv =3D drm_pipe_to_aspeed_gfx(pipe);
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> +	struct aspeed_gfx *priv =3D container_of(crtc, struct aspeed_gfx, crtc=
);
>
> Please use=C2=A0 your helper=C2=A0 to_aspeed_gfx(crtc->dev)=C2=A0 to do t=
he upcast.=C2=A0=20
> Here any in other places.
>

OK

>>  =20
>>   	aspeed_gfx_crtc_mode_set_nofb(priv);
>>   	aspeed_gfx_enable_controller(priv);
>>   	drm_crtc_vblank_on(crtc);
>>   }
>>  =20
>> -static void aspeed_gfx_pipe_disable(struct drm_simple_display_pipe *pip=
e)
>> +static void aspeed_gfx_crtc_helper_atomic_disable(struct drm_crtc *crtc=
,
>> +						  struct drm_atomic_commit *state)
>>   {
>> -	struct aspeed_gfx *priv =3D drm_pipe_to_aspeed_gfx(pipe);
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> +	struct aspeed_gfx *priv =3D container_of(crtc, struct aspeed_gfx, crtc=
);
>
> Another upcast issue
>

Acknowledged

>>  =20
>>   	drm_crtc_vblank_off(crtc);
>>   	aspeed_gfx_disable_controller(priv);
>>   }
>>  =20
>> -static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe=
,
>> -				   struct drm_plane_state *plane_state)
>> +static void aspeed_gfx_plane_helper_atomic_update(struct drm_plane *pla=
ne,
>> +						  struct drm_atomic_commit *state)
>>   {
>> -	struct aspeed_gfx *priv =3D drm_pipe_to_aspeed_gfx(pipe);
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> -	struct drm_framebuffer *fb =3D pipe->plane.state->fb;
>> +	struct aspeed_gfx *priv =3D container_of(plane, struct aspeed_gfx, pla=
ne);
>
> to_aspeed_gfx(plane->dev)
>

Acknowledged

>> +	struct drm_crtc *crtc =3D &priv->crtc;
>> +	struct drm_framebuffer *fb =3D plane->state->fb;
>>   	struct drm_pending_vblank_event *event;
>>   	struct drm_gem_dma_object *gem;
>>  =20
>> @@ -190,9 +183,9 @@ static void aspeed_gfx_pipe_update(struct drm_simple=
_display_pipe *pipe,
>>   	writel(gem->dma_addr, priv->base + CRT_ADDR);
>>   }
>>  =20
>> -static int aspeed_gfx_enable_vblank(struct drm_simple_display_pipe *pip=
e)
>> +static int aspeed_gfx_crtc_enable_vblank(struct drm_crtc *crtc)
>>   {
>> -	struct aspeed_gfx *priv =3D drm_pipe_to_aspeed_gfx(pipe);
>> +	struct aspeed_gfx *priv =3D container_of(crtc, struct aspeed_gfx, crtc=
);
>>   	u32 reg =3D readl(priv->base + CRT_CTRL1);
>>  =20
>>   	/* Clear pending VBLANK IRQ */
>> @@ -204,9 +197,9 @@ static int aspeed_gfx_enable_vblank(struct drm_simpl=
e_display_pipe *pipe)
>>   	return 0;
>>   }
>>  =20
>> -static void aspeed_gfx_disable_vblank(struct drm_simple_display_pipe *p=
ipe)
>> +static void aspeed_gfx_crtc_disable_vblank(struct drm_crtc *crtc)
>>   {
>> -	struct aspeed_gfx *priv =3D drm_pipe_to_aspeed_gfx(pipe);
>> +	struct aspeed_gfx *priv =3D container_of(crtc, struct aspeed_gfx, crtc=
);
>>   	u32 reg =3D readl(priv->base + CRT_CTRL1);
>>  =20
>>   	reg &=3D ~CRT_CTRL_VERTICAL_INTR_EN;
>> @@ -216,12 +209,75 @@ static void aspeed_gfx_disable_vblank(struct drm_s=
imple_display_pipe *pipe)
>>   	writel(reg | CRT_CTRL_VERTICAL_INTR_STS, priv->base + CRT_CTRL1);
>>   }
>>  =20
>> -static const struct drm_simple_display_pipe_funcs aspeed_gfx_funcs =3D =
{
>> -	.enable		=3D aspeed_gfx_pipe_enable,
>> -	.disable	=3D aspeed_gfx_pipe_disable,
>> -	.update		=3D aspeed_gfx_pipe_update,
>> -	.enable_vblank	=3D aspeed_gfx_enable_vblank,
>> -	.disable_vblank	=3D aspeed_gfx_disable_vblank,
>> +static int aspeed_gfx_plane_helper_atomic_check(struct drm_plane *plane=
,
>> +						struct drm_atomic_commit *state)
>> +{
>> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state=
(state, plane);
>> +	struct drm_crtc *crtc =3D plane_state->crtc;
>> +	struct drm_crtc_state *crtc_state =3D NULL;
>> +	int ret;
>> +
>> +	if (crtc)
>> +		crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
>> +
>> +	ret =3D drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  false, false);
>> +	return ret;
>> +}
>
> Return directly.
>

OK

>> +
>> +static const struct drm_plane_helper_funcs aspeed_gfx_plane_helper_func=
s =3D {
>> +	.prepare_fb	=3D drm_gem_plane_helper_prepare_fb,
>> +	.atomic_check	=3D aspeed_gfx_plane_helper_atomic_check,
>> +	.atomic_update	=3D aspeed_gfx_plane_helper_atomic_update,
>> +};
>> +
>> +static const struct drm_plane_funcs aspeed_gfx_plane_funcs =3D {
>> +	.update_plane		=3D drm_atomic_helper_update_plane,
>> +	.disable_plane		=3D drm_atomic_helper_disable_plane,
>> +	.destroy		=3D drm_plane_cleanup,
>> +	.reset			=3D drm_atomic_helper_plane_reset,
>> +	.atomic_duplicate_state	=3D drm_atomic_helper_plane_duplicate_state,
>> +	.atomic_destroy_state	=3D drm_atomic_helper_plane_destroy_state,
>> +};
>> +
>> +static int aspeed_gfx_crtc_helper_atomic_check(struct drm_crtc *crtc,
>> +					       struct drm_atomic_commit *state)
>> +{
>> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(st=
ate, crtc);
>> +	int ret;
>> +
>> +	if (!crtc_state->enable)
>> +		goto out;
>> +
>> +	ret =3D drm_atomic_helper_check_crtc_primary_plane(crtc_state);
>> +	if (ret)
>> +		return ret;
>> +
>> +out:
>> +	return drm_atomic_add_affected_planes(state, crtc);
>> +}
>
> See arcpgu on a possible style improvement.
>

Will do, thanks


> Best regards
> Thomas
>

[ ... ]

