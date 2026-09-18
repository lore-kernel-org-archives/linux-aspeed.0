Return-Path: <linux-aspeed+bounces-5029-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D019C982D0
	for <linux-aspeed@archiver.kernel.org>; Sun, 20 Sep 2026 07:46:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hndjT1hzYz2yK7;
	Sun, 20 Sep 2026 17:46:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789750728;
	cv=none; b=fW7sIWKQABrCkCgNGYCH7aqm7wPhwPXjyMdzy+sAXT1JWhOCLKqGApCcL1ptxlhrbf5SLLgMJkUwg/vhWUmFsVSzML2oaGwQ7Xd3jrotGT2eaIEBT+u4ggL5WkRrcB7EA8ora0Pv3O8vEzSJjFMlyNvy1MCBWCH0wjB5LlTrsNUxBWY7WMMQRAnS9O5idS6tXxjT/MKaGFSmjNTDrz+ueEmm3CyA3N1ySXP7af0uAONltvMBZGeISUN/Cldacdfr4Yg8sMQmu4jfZZBGhvulWUeocJ0UumqR3XPYHsxOFKpxRc6xCGZa8HK0sHHybIgQzg5QWKQMI29O40LME4QtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789750728; c=relaxed/relaxed;
	bh=FmJ9l5QFBMMe48wI+FnvFQSDXsCaB79a0WihlyuJstA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WPsXfFqEjjSLCdwOJxvlyrLc6S+/t9pENX62My+IrIfEtjIyefmOh9xin0p8MBMaSfCwTRY18C6DavYzdd01US2ZxblHE2smwE3OGdzDRItN7hwCu+fRmLsOtNNIVmbMxp2565mvrSpILjyKkVXbPzxDZTbHtA5tgA1c80b0KO0aKkexVcnjEFHMPXrq3I31ZgId1AyleXH4v/h3sg0e54G09wKeDn8yz4Zclzpj+R8Ui0ZwyDfz1F5Pt7SSvlskM45lcaV+c7LamzBjyFU13bV9RKp8ieVYiy17de1UUFx1MhW5nloyBHRon4s0GOFZJxdRkvtg3fQVCPPDun62VA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F862iJkl; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HPoZ11UW; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F862iJkl;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HPoZ11UW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmf3C4bR8z2xYg
	for <linux-aspeed@lists.ozlabs.org>; Sat, 19 Sep 2026 02:58:46 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IGo1Z92178318
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 16:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FmJ9l5QFBMMe48wI+FnvFQSDXsCaB79a0WihlyuJstA=; b=F862iJklfTEspXfc
	UjvRsNylWUiwop35P1muhLn10HTOL/M7stdoCV5Frgx1dJJyqJCtb9FvturdV8sv
	z3alBIEzMWiVlVthfKBVozYtF7rTFVwi4etMJQaCL3Xb1OMzWcr3mo94SqS0NKef
	R2spGU2cf3Z4YDgyNC0YvETba6iLNRQtX+MmCmDbez6Y2pZzcL6/1A49LPfbZR3+
	EwSgfygJ0q8qQ9GphKHYvddiZI3X3ZqEQSOuyLKfi60D+5Gm3ZpMKc/Bkp7QtCxC
	19jlA5mLGS4eEQmM2YLhernOpYqFKGMWVlTYHqEyqO4snc1SdLMMuu7ckn2KAGe8
	b6XcSg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs8gyg87e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 16:58:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc72777faa2so232784a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789750724; x=1790355524; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FmJ9l5QFBMMe48wI+FnvFQSDXsCaB79a0WihlyuJstA=;
        b=HPoZ11UWvtpVB6jNVmmGunlzaFqd4XJYpptC24vahymieO69eEKqGVW7xYtZGoi3Ai
         8VM1JOkd/FE77iY89UWYj3vAIGi8KudEtuD82GTlwHVIRjmr0Se8lzudbxRbooaanNtb
         GZlgLhPiUB7WqCbC3jVAUyNNP9L885TGqGLINkx6/t8TyzxZzNAfj5O4yt5RMjgoFJRH
         /25NKN1/thdCC/EdjyfGq6aIlzVkJwDm+eNKZQh1HL6bA21Q/oqIzrJh8okSl4zRLS4m
         /vn87q76QNduVfiMaAF+WEY0KvCxcfw9xnM8SlKdGQOeCoIQjZ7B40dVP8J3TkoJDxTI
         JCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750724; x=1790355524;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmJ9l5QFBMMe48wI+FnvFQSDXsCaB79a0WihlyuJstA=;
        b=g3smlbxqqThbzVE4UZv0Dp1SgHoyachsrJUqKsvTyO6GC7BM4CycdQ4RmNARRd+qKf
         PrUbbCSOLF9XyaxubZg4l7M5n3eiP++/7067maEPUwslKFja8EVuRJdGJOHqtR3ql+S5
         /67EixLyWHOk6MYeUlf6xIC5IUWlQfkBdFTiPG6aytDLuxAaIIuJMtXAFs7hJeT9Sb6D
         0/3WQQi4lPUZFX8IjSuhpqwYRAa+tmlhD0wjJkcJNAPJI8Fy5tolhgWASgfUuZLxAL4+
         Sma/7efOVCX8GiNaJ5vYsRIugdqnRCWmrHyMStdgMHGSLxfBt0ixTaNQuE2fYDyTAhVz
         ctpg==
X-Forwarded-Encrypted: i=1; AKwUvBw9AxkjWqFAShr9a6GVv5aRuB5zPuqxscMcB++iIb2bOdSmZfjtR1LKAPs91KEo/cSS9VF0lkZyzh56qKA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lvqK7slEK/CfADF1qYzw/Op/F7WdiSdXZ35/AiAVluoCH9krUy
	3Ybg6c4th17NYjJtolWay8FFBfHW0K7SxPqtOEBXjM+cUUgW35vLbpwZVdGMG2OVP3wjtPgicNn
	cS07gx5QS6dvF+G+nj5iUTJKYwOEbe4BoyMDxuIAawRvaxGMCozOp5GBkDHMo4g7sMCVM
X-Gm-Gg: AYBFou1PL76bAdSdEabdexQklr+LnBHYXxIQ3YkpnAB0vyAnwyWC+Om1HfIFV/s4gGI
	ZkE+D2OWeglKNF7cFNLRERjmEdE7IJj14kvux2i0OeQksd9nuKDKopkQI5UbEOkFVs3nlgXtvwu
	M49Tn/n/wnfzjF0+xlKs1pYrhsdEVqgCx6sC0Vi4xhiJxOlJHoT4yfYjDnnJoFfUjoo1QSINH7O
	io08WqS83W6a3P4/Zw844bRaLd0Gnm+jjlqgWWQB+lI3Vk8fOSVKxnQizjA/giNrqyRtBLyVVAp
	SF0FDSad/DyOWHy51AOsAdtD0WbL5wNfHKQIBx8UNGaw+eL8mHERd1fGLFezwAEJ1qYNUYlkv9D
	kaEzm2A==
X-Received: by 2002:a05:6a20:d707:b0:3dd:a195:fa0e with SMTP id adf61e73a8af0-3dda195fd95mr361312637.51.1789750723378;
        Fri, 18 Sep 2026 09:58:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:d707:b0:3dd:a195:fa0e with SMTP id adf61e73a8af0-3dda195fd95mr361267637.51.1789750722830;
        Fri, 18 Sep 2026 09:58:42 -0700 (PDT)
Received: from localhost ([143.246.51.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5c50e7433sm1426162a12.28.2026.09.18.09.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 09:58:42 -0700 (PDT)
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
Date: Sat, 19 Sep 2026 00:58:17 +0800
Message-Id: <DLILO7Y6WWXC.ON1PAKLWJM1Y@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 1/2] drm/imx/lcdc: avoid duplicate clk_per enable
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
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com> <20260727-drm-simple-kms-removal-v3-1-de36e534f7a1@oss.qualcomm.com> <bbf8fd0e-8e1c-4899-98f4-b8231800de8c@suse.de>
In-Reply-To: <bbf8fd0e-8e1c-4899-98f4-b8231800de8c@suse.de>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI0MiBTYWx0ZWRfX+x2weOkPP3qK
 C5FYPEoy8K0y/kn4Iz9phQkJNHbfWbGoQ+7LxacVpX9JOWvsL4SyGuyR14XDHOaIP19Uy41GlU9
 ZU0hCJtHgi6oEfs4GTy70dYTDIOSvnM=
X-Authority-Analysis: v=2.4 cv=Tq5zFzXh c=1 sm=1 tr=0 ts=6aad6dc4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=LNnhWNgewsfctp/cwirQdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=gNeoJdBQTLUQTwsD9V0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI0MiBTYWx0ZWRfXwsnqFhMSF3xb
 rB90A0wKK2rIGqCKLETVZPtA1mjPODqEelP9pxkPwJ4U1+Y33UUnGV1gliv2oGFJT5i264C8LxC
 hssjUYBUbLjjtcut3uSOqCl9g2/sFZSh6eTSUtX7muRh5eBMJBudjMcQwf+9i6c/9vFezcEOlBj
 LICGfeaPUzE5S90mZViCqsVrofqmay72dcUZV1T8FqylzleSNlQEaO7vVHXU7RQlZ26mBX29rbd
 MsgIwzwqkEbkWDTKX+ShOIA6ppjTjbo25/30ZdnE4WTR75AyYx5xwPpssu8+SHqv/7dHrKs9qdk
 3gxfCpolhq5idp/+8wOb88Iy8FPb3zvOLIKgx1Fep2ugI1s115zkhOZAAr14hgGm3Og4vBS8qNd
 NsceQVQk+FX8gsSHWJBiccqOrLKB4EMRRDCn3YStjhpyBJglk1II7bCNlOKFNhCMAxKfgR77Dgt
 /nJceirufrrPJ39+5Qg==
X-Proofpoint-ORIG-GUID: G19WTuyhNK-Q071VYRRX6x8Vq69xb2LZ
X-Proofpoint-GUID: G19WTuyhNK-Q071VYRRX6x8Vq69xb2LZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180242

On Wed Sep 16, 2026 at 2:24 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 26.07.26 um 21:42 schrieb Ze Huang:
>> The simple-KMS helper calls the pipe update after enabling the CRTC.
>> On an enable commit, imx_lcdc_pipe_enable() already programs the
>> mode and enables clk_per. The following pipe update sees the plane move
>> from no CRTC to the active CRTC, treats it as a mode update, and calls
>> imx_lcdc_update_hw_registers() again.
>>
>> That second call has no old CRTC state to disable clk_per first, but it
>> enables clk_per again at the end. The disable path only drops one
>> reference, leaving clk_per enabled after each on/off cycle.
>>
>> Skip the register update from the pipe update path when the CRTC already
>> needs a modeset. The enable path has already programmed the hardware for
>> that commit; keep the event handling in pipe update unchanged.
>

Thanks for your review.

> That seems reasonable. Once the driver uses regular DRM helpers instead=
=20
> of simple_kms,=20

> it can all be untangled and this test won't be necessary any longer.

Yes, that's the goal.

IMO it's better to spilt the operations in imx_lcdc_update_hw_registers()
or distinguish the caller.

However, it might be risky to make big changes without hardware validation,
I think it accpetable for now.

>
>>
>> Fixes: c87e859cdeb5 ("drm/imx/lcdc: Implement DRM driver for imx25")
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>> ---
>>   drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/l=
cdc/imx-lcdc.c
>> index f52832b43aca..81024f7d9e96 100644
>> --- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
>> +++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
>> @@ -311,7 +311,8 @@ static void imx_lcdc_pipe_update(struct drm_simple_d=
isplay_pipe *pipe,
>>   	else if (old_crtc !=3D crtc)
>>   		mode_changed =3D true;
>>  =20
>> -	imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
>> +	if (!drm_atomic_crtc_needs_modeset(crtc->state))
>> +		imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
>>  =20
>>   	if (event) {
>>   		crtc->state->event =3D NULL;
>>



