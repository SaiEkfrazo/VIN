# # your_app/signals.py
# from django.db.models.signals import post_save
# from django.dispatch import receiver
# from django.utils import timezone
# from .models import Reports, Defects, DefectNotification

# @receiver(post_save, sender=Reports)
# def update_consecutive_defect_count(sender, instance, **kwargs):
#     current_defect = instance.defect
#     last_occurrence_time = current_defect.last_occurrence_time

#     # Check if the last occurrence was recent enough to be considered consecutive
#     if last_occurrence_time and (timezone.now() - last_occurrence_time).total_seconds() < 3600:
#         # Increment the consecutive count if the defect occurred recently
#         current_defect.consecutive_count += 1
#     else:
#         # Reset the count if it's a new occurrence after a significant delay
#         current_defect.consecutive_count = 1

#     current_defect.last_occurrence_time = timezone.now()
#     current_defect.save()

#     # Check if the defect occurred three times consecutively
#     if current_defect.consecutive_count >= 3:
#         # Create a DefectNotification
#         DefectNotification.objects.create(
#             defect=current_defect,
#             notification_text=f"Defect '{current_defect.name}' has occurred three times consecutively."
#         )
